# Windows Job Object：讓子程序隨父程序結束

> 狀態：已驗證（單一環境）｜收錄：2026-11-08｜來源：個人研發產品（已去識別化）

## 問題
程式會啟動外部程序（例如 ffmpeg），父程序被強制結束、當掉或重啟時，Windows **不會**一併結束子程序，子程序變成孤兒繼續活著。

實際後果：伺服器暫停合成（把 ffmpeg 凍結）後被重啟，凍結的 ffmpeg 一直占著 NAS 上的半成品檔與顯卡記憶體，之後清除暫存檔因「檔案使用中」刪不掉。

## 解法
啟動時把**父程序自己**放進一個設了 `JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE` 的 Job Object。之後它建立的子程序自動屬於同一個 Job；父程序一消失（握把隨之關閉），Job 內所有程序一起結束。

```python
import ctypes
from ctypes import wintypes

_job = None   # 握把必須保持到行程結束，不能被回收

def kill_children_on_exit() -> bool:
    global _job
    k = ctypes.WinDLL("kernel32", use_last_error=True)
    k.CreateJobObjectW.restype = wintypes.HANDLE
    k.CreateJobObjectW.argtypes = [wintypes.LPVOID, wintypes.LPCWSTR]
    k.SetInformationJobObject.argtypes = [wintypes.HANDLE, ctypes.c_int, wintypes.LPVOID, wintypes.DWORD]
    k.AssignProcessToJobObject.argtypes = [wintypes.HANDLE, wintypes.HANDLE]
    k.GetCurrentProcess.restype = wintypes.HANDLE

    class Basic(ctypes.Structure):
        _fields_ = [("PerProcessUserTimeLimit", ctypes.c_int64), ("PerJobUserTimeLimit", ctypes.c_int64),
                    ("LimitFlags", wintypes.DWORD), ("MinimumWorkingSetSize", ctypes.c_size_t),
                    ("MaximumWorkingSetSize", ctypes.c_size_t), ("ActiveProcessLimit", wintypes.DWORD),
                    ("Affinity", ctypes.c_size_t), ("PriorityClass", wintypes.DWORD), ("SchedulingClass", wintypes.DWORD)]
    class Io(ctypes.Structure):
        _fields_ = [(n, ctypes.c_uint64) for n in ("r", "w", "o", "rb", "wb", "ob")]
    class Extended(ctypes.Structure):
        _fields_ = [("Basic", Basic), ("Io", Io), ("ProcessMemoryLimit", ctypes.c_size_t),
                    ("JobMemoryLimit", ctypes.c_size_t), ("PeakProcessMemoryUsed", ctypes.c_size_t),
                    ("PeakJobMemoryUsed", ctypes.c_size_t)]

    job = k.CreateJobObjectW(None, None)
    info = Extended(); info.Basic.LimitFlags = 0x2000          # KILL_ON_JOB_CLOSE
    if not job or not k.SetInformationJobObject(job, 9, ctypes.byref(info), ctypes.sizeof(info)):  # 9 = ExtendedLimitInformation
        return False
    if not k.AssignProcessToJobObject(job, k.GetCurrentProcess()):
        return False
    _job = job
    return True
```
- 在程式**最早期**呼叫（啟動任何子程序之前）。失敗時回傳 False、不要讓程式起不來，這只是保護機制。
- 注意 `argtypes`／`restype` 要指定：64 位元下握把預設會被截成 32 位元。

## 驗證依據（已驗證）
測試環境：Windows 11 Pro（10.0.26200）、Python 3.11.5、ctypes。方法：父程序啟動一個睡 120 秒的子程序，測試端強制結束父程序，1.5 秒後檢查子程序是否還在。

| 情況 | 結果 |
|---|---|
| 父程序**有**呼叫上述函式 | 子程序隨之結束 |
| 對照組：**沒有**呼叫 | 子程序仍活著（即原本的問題） |
| 實際伺服器啟動後，用 `IsProcessInJob` 查本體 | 在 Job 內 |

有對照組，所以不是測試自己造成的結果。

## 限制與適用條件
- **只有呼叫之後才建立的子程序**受保護；呼叫之前已經在跑的不會被拉進來。
- 子程序若用 `CREATE_BREAKAWAY_FROM_JOB` 建立，會脫離 Job（本案未用）。
- 結束是**強制的**，子程序沒有機會清理；它寫到一半的檔案會留在原處，仍需自己的暫存檔清理機制。
- 父程序已在不允許巢狀的 Job 內時，`AssignProcessToJobObject` 會失敗（Windows 7 才有這個限制），本函式會回傳 False。
- Windows 專用。其他系統要用別的機制（例如 Linux 的 `prctl(PR_SET_PDEATHSIG)` 或行程群組），**本次未驗證**。

## 尚未驗證
- 被**凍結（suspended）**的子程序是否同樣被結束：測試用的是睡眠中的子程序，沒有實際測凍結狀態；依 Windows 行為應該會，但未實測。
- Windows 11 以外的版本、非 Python 實作。
- 孫程序（子程序再建立的子程序）：預期也在 Job 內，未專門測。

## 來源
某個個人研發產品（行程樹終止模組與其測試），2026-11-08。產品專屬的整合（在程式啟動時呼叫）留在該產品，不在本文件。
