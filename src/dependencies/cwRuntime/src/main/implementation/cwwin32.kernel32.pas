{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
unit cwWin32.Kernel32;

interface
{$ifdef MSWINDOWS}
uses
  cwWin32.Types
;

const
  cLibName = 'kernel32.dll';

function AddAtom(lpString: PAnsiChar): TAtom; stdcall; external cLibName name 'AddAtomA';
function AddAtomW(lpString: PWideChar): TAtom; stdcall; external cLibName name 'AddAtomW';
function AllocConsole: BOOL; stdcall; external cLibName name 'AllocConsole';
function AreFileApisANSI: BOOL; stdcall; external cLibName name 'AreFileApisANSI';
function BackupRead(hFile: THandle; lpBuffer: PByte; nNumberOfBytesToRead: DWORD; var lpNumberOfBytesRead: DWORD; bAbort: BOOL; bProcessSecurity: BOOL; var lpContext: Pointer): BOOL; stdcall; external cLibName name 'BackupRead';
function BackupSeek(hFile: THandle; dwLowBytesToSeek, dwHighBytesToSeek: DWORD; var lpdwLowByteSeeked, lpdwHighByteSeeked: DWORD; lpContext: Pointer): BOOL; stdcall; external cLibName name 'BackupSeek';
function BackupWrite(hFile: THandle; lpBuffer: PByte; nNumberOfBytesToWrite: DWORD; var lpNumberOfBytesWritten: DWORD; bAbort, bProcessSecurity: BOOL; var lpContext: Pointer): BOOL; stdcall; external cLibName name 'BackupWrite';
function Beep(dwFreq, dwDuration: DWORD): BOOL; stdcall; external cLibName name 'Beep';
function BeginUpdateResource(pFileName: PAnsiChar; bDeleteExistingResources: BOOL): THandle; stdcall; external cLibName name 'BeginUpdateResourceA';
function BeginUpdateResourceW(pFileName: PWideChar; bDeleteExistingResources: BOOL): THandle; stdcall; external cLibName name 'BeginUpdateResourceW';
function BuildCommDCB(lpDef: PAnsiChar; var lpDCB: TDCB): BOOL; stdcall; external cLibName name 'BuildCommDCBA';
function BuildCommDCBAndTimeouts(lpDef: PAnsiChar; var lpDCB: TDCB; var lpCommTimeouts: TCommTimeouts): BOOL; stdcall; external cLibName name 'BuildCommDCBAndTimeoutsA';
function BuildCommDCBAndTimeoutsW(lpDef: PWideChar; var lpDCB: TDCB; var lpCommTimeouts: TCommTimeouts): BOOL; stdcall; external cLibName name 'BuildCommDCBAndTimeoutsW';
function BuildCommDCBW(lpDef: PWideChar; var lpDCB: TDCB): BOOL; stdcall; external cLibName name 'BuildCommDCBW';
function CallNamedPipe(lpNamedPipeName: PAnsiChar; lpInBuffer: Pointer; nInBufferSize: DWORD; lpOutBuffer: Pointer; nOutBufferSize: DWORD; var lpBytesRead: DWORD; nTimeOut: DWORD): BOOL; stdcall; external cLibName name 'CallNamedPipeA';
function CallNamedPipeW(lpNamedPipeName: PWideChar; lpInBuffer: Pointer; nInBufferSize: DWORD; lpOutBuffer: Pointer; nOutBufferSize: DWORD; var lpBytesRead: DWORD; nTimeOut: DWORD): BOOL; stdcall; external cLibName name 'CallNamedPipeW';
function CancelIo(hFile: THandle): BOOL; stdcall; external cLibName name 'CancelIo';
function CancelWaitableTimer(hTimer: THandle): BOOL; stdcall; external cLibName name 'CancelWaitableTimer';
function ClearCommBreak(hFile: THandle): BOOL; stdcall; external cLibName name 'ClearCommBreak';
function ClearCommError(hFile: THandle; var lpErrors: DWORD; lpStat: PComStat): BOOL; stdcall; external cLibName name 'ClearCommError';
function CloseHandle(hObject: THandle): BOOL; stdcall; external cLibName name 'CloseHandle';
function CommConfigDialog(lpszName: PAnsiChar; hWnd: THWND; var lpCC: TCommConfig): BOOL; stdcall; external cLibName name 'CommConfigDialogA';
function CommConfigDialogW(lpszName: PWideChar; hWnd: THWND; var lpCC: TCommConfig): BOOL; stdcall; external cLibName name 'CommConfigDialogW';
function CompareFileTime(const lpFileTime1, lpFileTime2: TFileTime): Longint; stdcall; external cLibName name 'CompareFileTime';
function CompareString(Locale: LCID; dwCmpFlags: DWORD; lpString1: PAnsiChar; cchCount1: Integer; lpString2: PAnsiChar; cchCount2: Integer): Integer; stdcall; external cLibName name 'CompareStringA';
function CompareStringW(Locale: LCID; dwCmpFlags: DWORD; lpString1: PWideChar; cchCount1: Integer; lpString2: PWideChar; cchCount2: Integer): Integer; stdcall; external cLibName name 'CompareStringW';
function ConnectNamedPipe(hNamedPipe: THandle; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'ConnectNamedPipe';
function ContinueDebugEvent(dwProcessId, dwThreadId, dwContinueStatus: DWORD): BOOL; stdcall; external cLibName name 'ContinueDebugEvent';
function ConvertDefaultLocale(Locale: LCID): LCID; stdcall; external cLibName name 'ConvertDefaultLocale';
function ConvertThreadToFiber(lpParameter: Pointer): BOOL; stdcall; external cLibName name 'ConvertThreadToFiber';
function CopyFile(lpExistingFileName, lpNewFileName: PAnsiChar; bFailIfExists: BOOL): BOOL; stdcall; external cLibName name 'CopyFileA';
function CopyFileEx(lpExistingFileName, lpNewFileName: PAnsiChar; lpProgressRoutine: TCopyProgressRoutine; lpData: Pointer; pbCancel: PBool; dwCopyFlags: DWORD): BOOL; stdcall; external cLibName name 'CopyFileExA';
function CopyFileExW(lpExistingFileName, lpNewFileName: PWideChar; lpProgressRoutine: TCopyProgressRoutine; lpData: Pointer; pbCancel: PBool; dwCopyFlags: DWORD): BOOL; stdcall; external cLibName name 'CopyFileExW';
function CopyFileW(lpExistingFileName, lpNewFileName: PWideChar; bFailIfExists: BOOL): BOOL; stdcall; external cLibName name 'CopyFileW';
function CreateConsoleScreenBuffer(dwDesiredAccess, dwShareMode: DWORD; lpSecurityAttributes: PSecurityAttributes; dwFlags: DWORD; lpScreenBufferData: Pointer): THandle; stdcall; external cLibName name 'CreateConsoleScreenBuffer';
function CreateDirectory(lpPathName: PAnsiChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateDirectoryA';
function CreateDirectoryEx(lpTemplateDirectory, lpNewDirectory: PAnsiChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateDirectoryExA';
function CreateDirectoryExW(lpTemplateDirectory, lpNewDirectory: PWideChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateDirectoryExW';
function CreateDirectoryW(lpPathName: PWideChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateDirectoryW';
function CreateEvent(lpEventAttributes: PSecurityAttributes; bManualReset, bInitialState: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'CreateEventA';
function CreateEventW(lpEventAttributes: PSecurityAttributes; bManualReset, bInitialState: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'CreateEventW';
function CreateFiber(dwStackSize: DWORD; lpStartAddress: TFiberProc; lpParameter: Pointer): BOOL; stdcall; external cLibName name 'CreateFiber';
function CreateFile(lpFileName: PAnsiChar; dwDesiredAccess, dwShareMode: DWORD; lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD; hTemplateFile: THandle): THandle; stdcall; external cLibName name 'CreateFileA';
function CreateFileMapping(hFile: THandle; lpFileMappingAttributes: PSecurityAttributes; flProtect, dwMaximumSizeHigh, dwMaximumSizeLow: DWORD; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'CreateFileMappingA';
function CreateFileMappingW(hFile: THandle; lpFileMappingAttributes: PSecurityAttributes; flProtect, dwMaximumSizeHigh, dwMaximumSizeLow: DWORD; lpName: PWideChar): THandle; stdcall; external cLibName name 'CreateFileMappingW';
function CreateFileW(lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD; lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD; hTemplateFile: THandle): THandle; stdcall; external cLibName name 'CreateFileW';
function CreateHardLink(lpFileName, lpExistingFileName: PAnsiChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateHardLinkA';
function CreateHardLinkW(lpFileName, lpExistingFileName: PWideChar; lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external cLibName name 'CreateHardLinkW';
function CreateIoCompletionPort(FileHandle, ExistingCompletionPort: THandle; CompletionKey, NumberOfConcurrentThreads: DWORD): THandle; stdcall; external cLibName name 'CreateIoCompletionPort';
function CreateMailslot(lpName: PAnsiChar; nMaxMessageSize: DWORD; lReadTimeout: DWORD; lpSecurityAttributes: PSecurityAttributes): THandle; stdcall; external cLibName name 'CreateMailslotA';
function CreateMailslotW(lpName: PWideChar; nMaxMessageSize: DWORD; lReadTimeout: DWORD; lpSecurityAttributes: PSecurityAttributes): THandle; stdcall; external cLibName name 'CreateMailslotW';
function CreateMutex(lpMutexAttributes: PSecurityAttributes; bInitialOwner: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'CreateMutexA';
function CreateMutexW(lpMutexAttributes: PSecurityAttributes; bInitialOwner: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'CreateMutexW';
function CreateNamedPipe(lpName: PAnsiChar; dwOpenMode, dwPipeMode, nMaxInstances, nOutBufferSize, nInBufferSize, nDefaultTimeOut: DWORD; lpSecurityAttributes: PSecurityAttributes): THandle; stdcall; external cLibName name 'CreateNamedPipeA';
function CreateNamedPipeW(lpName: PWideChar; dwOpenMode, dwPipeMode, nMaxInstances, nOutBufferSize, nInBufferSize, nDefaultTimeOut: DWORD; lpSecurityAttributes: PSecurityAttributes): THandle; stdcall; external cLibName name 'CreateNamedPipeW';
function CreatePipe(var hReadPipe, hWritePipe: THandle; lpPipeAttributes: PSecurityAttributes; nSize: DWORD): BOOL; stdcall; external cLibName name 'CreatePipe';
function CreateProcess(lpApplicationName: PAnsiChar; lpCommandLine: PAnsiChar; lpProcessAttributes, lpThreadAttributes: PSecurityAttributes; bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer; lpCurrentDirectory: PAnsiChar; const lpStartupInfo: TStartupInfoA; var lpProcessInformation: TProcessInformation): BOOL; stdcall; external cLibName name 'CreateProcessA';
function CreateProcessW(lpApplicationName: PWideChar; lpCommandLine: PWideChar; lpProcessAttributes, lpThreadAttributes: PSecurityAttributes; bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer; lpCurrentDirectory: PWideChar; const lpStartupInfo: TStartupInfoW; var lpProcessInformation: TProcessInformation): BOOL; stdcall; external cLibName name 'CreateProcessW';
function CreateRemoteThread(hProcess: THandle; lpThreadAttributes: Pointer; dwStackSize: DWORD; lpStartAddress: TThreadProc; lpParameter: Pointer; dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall; external cLibName name 'CreateRemoteThread';
function CreateSemaphore(lpSemaphoreAttributes: PSecurityAttributes; lInitialCount, lMaximumCount: Longint; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'CreateSemaphoreA';
function CreateSemaphoreW(lpSemaphoreAttributes: PSecurityAttributes; lInitialCount, lMaximumCount: Longint; lpName: PWideChar): THandle; stdcall; external cLibName name 'CreateSemaphoreW';
function CreateTapePartition(hDevice: THandle; dwPartitionMethod, dwCount, dwSize: DWORD): DWORD; stdcall; external cLibName name 'CreateTapePartition';
function CreateThread(lpThreadAttributes: PSecurityAttributes; dwStackSize: DWORD; lpStartAddress: TThreadProc; lpParameter: Pointer; dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall; external cLibName name 'CreateThread';
function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): THandle; stdcall; external cLibName name 'CreateToolhelp32Snapshot';
function CreateWaitableTimer(lpTimerAttributes: PSecurityAttributes; bManualReset: BOOL; lpTimerName: PAnsiChar): THandle; stdcall; external cLibName name 'CreateWaitableTimerA';
function CreateWaitableTimerW(lpTimerAttributes: PSecurityAttributes; bManualReset: BOOL; lpTimerName: PWideChar): THandle; stdcall; external cLibName name 'CreateWaitableTimerW';
function DebugActiveProcess(dwProcessId: DWORD): BOOL; stdcall; external cLibName name 'DebugActiveProcess';
procedure DebugBreak; stdcall; external cLibName name 'DebugBreak';
function DefineDosDevice(dwFlags: DWORD; lpDeviceName, lpTargetPath: PAnsiChar): BOOL; stdcall; external cLibName name 'DefineDosDeviceA';
function DefineDosDeviceW(dwFlags: DWORD; lpDeviceName, lpTargetPath: PWideChar): BOOL; stdcall; external cLibName name 'DefineDosDeviceW';
function DeleteAtom(nAtom: TATOM): TATOM; stdcall; external cLibName name 'DeleteAtom';
procedure DeleteCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external cLibName name 'DeleteCriticalSection';
function DeleteFiber(lpFiber: Pointer): BOOL; stdcall; external cLibName name 'DeleteFiber';
function DeleteFile(lpFileName: PAnsiChar): BOOL; stdcall; external cLibName name 'DeleteFileA';
function DeleteFileW(lpFileName: PWideChar): BOOL; stdcall; external cLibName name 'DeleteFileW';
function DeviceIoControl(hDevice: THandle; dwIoControlCode: DWORD; lpInBuffer: Pointer; nInBufferSize: DWORD; lpOutBuffer: Pointer; nOutBufferSize: DWORD; var lpBytesReturned: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'DeviceIoControl';
function DisableThreadLibraryCalls(hLibModule: HMODULE): BOOL; stdcall; external cLibName name 'DisableThreadLibraryCalls';
function DisconnectNamedPipe(hNamedPipe: THandle): BOOL; stdcall; external cLibName name 'DisconnectNamedPipe';
function DosDateTimeToFileTime(wFatDate, wFatTime: Word; var lpFileTime: TFileTime): BOOL; stdcall; external cLibName name 'DosDateTimeToFileTime';
function DuplicateHandle(hSourceProcessHandle, hSourceHandle, hTargetProcessHandle: THandle; lpTargetHandle: PHandle; dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwOptions: DWORD): BOOL; stdcall; external cLibName name 'DuplicateHandle';
function EndUpdateResource(hUpdate: THandle; fDiscard: BOOL): BOOL; stdcall; external cLibName name 'EndUpdateResourceA';
function EndUpdateResourceW(hUpdate: THandle; fDiscard: BOOL): BOOL; stdcall; external cLibName name 'EndUpdateResourceW';
procedure EnterCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external cLibName name 'EnterCriticalSection';
function EnumCalendarInfo(lpCalInfoEnumProc: TCalInfoEnumProcA; Locale: LCID; Calendar: CALID; CalType: CALTYPE): BOOL; stdcall; external cLibName name 'EnumCalendarInfoA';
function EnumCalendarInfoW(lpCalInfoEnumProc: TCalInfoEnumProcW; Locale: LCID; Calendar: CALID; CalType: CALTYPE): BOOL; stdcall; external cLibName name 'EnumCalendarInfoW';
function EnumDateFormats(lpDateFmtEnumProc: TDateFmtEnumProcA; Locale: LCID; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumDateFormatsA';
function EnumDateFormatsW(lpDateFmtEnumProc: TDateFmtEnumProcW; Locale: LCID; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumDateFormatsW';
function EnumResourceLanguages(hModule: HMODULE; lpType, lpName: PAnsiChar; lpEnumFunc: TEnumResLangProcA; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceLanguagesA';
function EnumResourceLanguagesW(hModule: HMODULE; lpType, lpName: PWideChar; lpEnumFunc: TEnumResLangProcW; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceLanguagesW';
function EnumResourceNames(hModule: HMODULE; lpType: PAnsiChar; lpEnumFunc: TEnumResNameProcA; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceNamesA';
function EnumResourceNamesW(hModule: HMODULE; lpType: PWideChar; lpEnumFunc: TEnumResNameProcW; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceNamesW';
function EnumResourceTypes(hModule: HMODULE; lpEnumFunc: TEnumResTypeProcA; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceTypesA';
function EnumResourceTypesW(hModule: HMODULE; lpEnumFunc: TEnumResTypeProcW; lParam: Longint): BOOL; stdcall; external cLibName name 'EnumResourceTypesW';
function EnumSystemCodePages(lpCodePageEnumProc: TEnumCodePageProcA; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumSystemCodePagesA';
function EnumSystemCodePagesW(lpCodePageEnumProc: TEnumCodePageProcW; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumSystemCodePagesW';
function EnumSystemLocales(lpLocaleEnumProc: TEnumLocaleProcA; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumSystemLocalesA';
function EnumSystemLocalesW(lpLocaleEnumProc: TEnumLocaleProcW; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumSystemLocalesW';
function EnumTimeFormats(lpTimeFmtEnumProc: TEnumTimeFmtProcA; Locale: LCID; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumTimeFormatsA';
function EnumTimeFormatsW(lpTimeFmtEnumProc: TEnumTimeFmtProcW; Locale: LCID; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumTimeFormatsW';
function EraseTape(hDevice: THandle; dwEraseType: DWORD; bImmediate: BOOL): DWORD; stdcall; external cLibName name 'EraseTape';
function EscapeCommFunction(hFile: THandle; dwFunc: DWORD): BOOL; stdcall; external cLibName name 'EscapeCommFunction';
procedure ExitProcess(uExitCode: UINT); stdcall; external cLibName name 'ExitProcess';
procedure ExitThread(dwExitCode: DWORD); stdcall; external cLibName name 'ExitThread';
function ExpandEnvironmentStrings(lpSrc: PAnsiChar; lpDst: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'ExpandEnvironmentStringsA';
function ExpandEnvironmentStringsW(lpSrc: PWideChar; lpDst: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'ExpandEnvironmentStringsW';
procedure FatalAppExit(uAction: UINT; lpMessageText: PAnsiChar); stdcall; external cLibName name 'FatalAppExitA';
procedure FatalAppExitW(uAction: UINT; lpMessageText: PWideChar); stdcall; external cLibName name 'FatalAppExitW';
procedure FatalExit(ExitCode: Integer); stdcall; external cLibName name 'FatalExit';
function FileTimeToDosDateTime(const lpFileTime: TFileTime; var lpFatDate, lpFatTime: Word): BOOL; stdcall; external cLibName name 'FileTimeToDosDateTime';
function FileTimeToLocalFileTime(const lpFileTime: TFileTime; var lpLocalFileTime: TFileTime): BOOL; stdcall; external cLibName name 'FileTimeToLocalFileTime';
function FileTimeToSystemTime(const lpFileTime: TFileTime; var lpSystemTime: TSystemTime): BOOL; stdcall; external cLibName name 'FileTimeToSystemTime';
function FillConsoleOutputAttribute(hConsoleOutput: THandle; wAttribute: Word; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfAttrsWritten: DWORD): BOOL; stdcall; external cLibName name 'FillConsoleOutputAttribute';
function FillConsoleOutputCharacter(hConsoleOutput: THandle; cCharacter: AnsiChar; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfCharsWritten: DWORD): BOOL; stdcall; external cLibName name 'FillConsoleOutputCharacterA';
function FillConsoleOutputCharacterW(hConsoleOutput: THandle; cCharacter: WideChar; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfCharsWritten: DWORD): BOOL; stdcall; external cLibName name 'FillConsoleOutputCharacterW';
function FindAtom(lpString: PAnsiChar): TATOM; stdcall; external cLibName name 'FindAtomA';
function FindAtomW(lpString: PWideChar): TATOM; stdcall; external cLibName name 'FindAtomW';
function FindClose(hFindFile: THandle): BOOL; stdcall; external cLibName name 'FindClose';
function FindCloseChangeNotification(hChangeHandle: THandle): BOOL; stdcall; external cLibName name 'FindCloseChangeNotification';
function FindFirstChangeNotification(lpPathName: PAnsiChar; bWatchSubtree: BOOL; dwNotifyFilter: DWORD): THandle; stdcall; external cLibName name 'FindFirstChangeNotificationA';
function FindFirstChangeNotificationW(lpPathName: PWideChar; bWatchSubtree: BOOL; dwNotifyFilter: DWORD): THandle; stdcall; external cLibName name 'FindFirstChangeNotificationW';
function FindFirstFile(lpFileName: pointer; lpFindFileData: PWIN32FindDataA): THandle; stdcall; external cLibName name 'FindFirstFileA';
function FindFirstFileW(lpFileName: pointer; lpFindFileData: PWIN32FindDataW): THandle; stdcall; external cLibName name 'FindFirstFileW';
function FindFirstFileEx(lpFileName: PAnsiChar; fInfoLevelId: TFindexInfoLevels; lpFindFileData: Pointer; fSearchOp: TFindexSearchOps; lpSearchFilter: Pointer; dwAdditionalFlags: DWORD): BOOL; stdcall; external cLibName name 'FindFirstFileExA';
function FindFirstFileExW(lpFileName: PWideChar; fInfoLevelId: TFindexInfoLevels; lpFindFileData: Pointer; fSearchOp: TFindexSearchOps; lpSearchFilter: Pointer; dwAdditionalFlags: DWORD): BOOL; stdcall; external cLibName name 'FindFirstFileExW';
function FindNextChangeNotification(hChangeHandle: THandle): BOOL; stdcall; external cLibName name 'FindNextChangeNotification';
function FindNextFile(hFindFile: THandle; lpFindFileData: PWIN32FindDataA): BOOL; stdcall; external cLibName name 'FindNextFileA';
function FindNextFileW(hFindFile: THandle; lpFindFileData: PWIN32FindDataW): BOOL; stdcall; external cLibName name 'FindNextFileW';
function FindResource(hModule: HMODULE; lpName, lpType: PAnsiChar): THRSRC; stdcall; external cLibName name 'FindResourceA';
function FindResourceEx(hModule: HMODULE; lpType, lpName: PAnsiChar; wLanguage: Word): THRSRC; stdcall; external cLibName name 'FindResourceExA';
function FindResourceExW(hModule: HMODULE; lpType, lpName: PWideChar; wLanguage: Word): THRSRC; stdcall; external cLibName name 'FindResourceExW';
function FindResourceW(hModule: HMODULE; lpName, lpType: PWideChar): THRSRC; stdcall; external cLibName name 'FindResourceW';
function FlushConsoleInputBuffer(hConsoleInput: THandle): BOOL; stdcall; external cLibName name 'FlushConsoleInputBuffer';
function FlushFileBuffers(hFile: THandle): BOOL; stdcall; external cLibName name 'FlushFileBuffers';
function FlushInstructionCache(hProcess: THandle; const lpBaseAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external cLibName name 'FlushInstructionCache';
function FlushViewOfFile(const lpBaseAddress: Pointer; dwNumberOfBytesToFlush: DWORD): BOOL; stdcall; external cLibName name 'FlushViewOfFile';
function FoldString(dwMapFlags: DWORD; lpSrcStr: PAnsiChar; cchSrc: Integer; lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall; external cLibName name 'FoldStringA';
function FoldStringW(dwMapFlags: DWORD; lpSrcStr: PWideChar; cchSrc: Integer; lpDestStr: PWideChar; cchDest: Integer): Integer; stdcall; external cLibName name 'FoldStringW';
function FormatMessage(dwFlags: DWORD; lpSource: Pointer; dwMessageId: DWORD; dwLanguageId: DWORD; lpBuffer: PAnsiChar; nSize: DWORD; Arguments: Pointer): DWORD; stdcall; external cLibName name 'FormatMessageA';
function FormatMessageW(dwFlags: DWORD; lpSource: Pointer; dwMessageId: DWORD; dwLanguageId: DWORD; lpBuffer: PWideChar; nSize: DWORD; Arguments: Pointer): DWORD; stdcall; external cLibName name 'FormatMessageW';
function FreeConsole: BOOL; stdcall; external cLibName name 'FreeConsole';
function FreeEnvironmentStrings(p1: PAnsiChar): BOOL; stdcall; external cLibName name 'FreeEnvironmentStringsA';
function FreeEnvironmentStringsW(p1: PWideChar): BOOL; stdcall; external cLibName name 'FreeEnvironmentStringsW';
function FreeLibrary(hLibModule: HMODULE): BOOL; stdcall; external cLibName name 'FreeLibrary';
procedure FreeLibraryAndExitThread(hLibModule: HMODULE; dwExitCode: DWORD); stdcall; external cLibName name 'FreeLibraryAndExitThread';
function FreeResource(hResData: HGLOBAL): BOOL; stdcall; external cLibName name 'FreeResource';
function GenerateConsoleCtrlEvent(dwCtrlEvent: DWORD; dwProcessGroupId: DWORD): BOOL; stdcall; external cLibName name 'GenerateConsoleCtrlEvent';
function GetACP: UINT; stdcall; external cLibName name 'GetACP';
function GetAtomName(nAtom: TATOM; lpBuffer: PAnsiChar; nSize: Integer): UINT; stdcall; external cLibName name 'GetAtomNameA';
function GetAtomNameW(nAtom: TATOM; lpBuffer: PWideChar; nSize: Integer): UINT; stdcall; external cLibName name 'GetAtomNameW';
function GetBinaryType(lpApplicationName: PAnsiChar; var lpBinaryType: DWORD): BOOL; stdcall; external cLibName name 'GetBinaryTypeA';
function GetBinaryTypeW(lpApplicationName: PWideChar; var lpBinaryType: DWORD): BOOL; stdcall; external cLibName name 'GetBinaryTypeW';
function GetCPInfo(CodePage: UINT; var lpCPInfo: TCPInfo): BOOL; stdcall; external cLibName name 'GetCPInfo';
function GetCommConfig(hCommDev: THandle; var lpCC: TCommConfig; var lpdwSize: DWORD): BOOL; stdcall; external cLibName name 'GetCommConfig';
function GetCommMask(hFile: THandle; var lpEvtMask: DWORD): BOOL; stdcall; external cLibName name 'GetCommMask';
function GetCommModemStatus(hFile: THandle; var lpModemStat: DWORD): BOOL; stdcall; external cLibName name 'GetCommModemStatus';
function GetCommProperties(hFile: THandle; var lpCommProp: TCommProp): BOOL; stdcall; external cLibName name 'GetCommProperties';
function GetCommState(hFile: THandle; var lpDCB: TDCB): BOOL; stdcall; external cLibName name 'GetCommState';
function GetCommTimeouts(hFile: THandle; var lpCommTimeouts: TCommTimeouts): BOOL; stdcall; external cLibName name 'GetCommTimeouts';
function GetCommandLine: PAnsiChar; stdcall; external cLibName name 'GetCommandLineA';
function GetCommandLineW: PWideChar; stdcall; external cLibName name 'GetCommandLineW';
function GetCompressedFileSize(lpFileName: PAnsiChar; lpFileSizeHigh: PDWORD): DWORD; stdcall; external cLibName name 'GetCompressedFileSizeA';
function GetCompressedFileSizeW(lpFileName: PWideChar; lpFileSizeHigh: PDWORD): DWORD; stdcall; external cLibName name 'GetCompressedFileSizeW';
function GetComputerName(lpBuffer: PAnsiChar; var nSize: DWORD): BOOL; stdcall; external cLibName name 'GetComputerNameA';
function GetComputerNameW(lpBuffer: PWideChar; var nSize: DWORD): BOOL; stdcall; external cLibName name 'GetComputerNameW';
function GetConsoleCP: UINT; stdcall; external cLibName name 'GetConsoleCP';
function GetConsoleCursorInfo(hConsoleOutput: THandle; var lpConsoleCursorInfo: TConsoleCursorInfo): BOOL; stdcall; external cLibName name 'GetConsoleCursorInfo';
function GetConsoleMode(hConsoleHandle: THandle; var lpMode: DWORD): BOOL; stdcall; external cLibName name 'GetConsoleMode';
function GetConsoleOutputCP: UINT; stdcall; external cLibName name 'GetConsoleOutputCP';
function GetConsoleScreenBufferInfo(hConsoleOutput: THandle; var lpConsoleScreenBufferInfo: TConsoleScreenBufferInfo): BOOL; stdcall; external cLibName name 'GetConsoleScreenBufferInfo';
function GetConsoleTitle(lpConsoleTitle: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetConsoleTitleA';
function GetConsoleTitleW(lpConsoleTitle: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetConsoleTitleW';
function GetCurrencyFormat(Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar; lpFormat: PCurrencyFmtA; lpCurrencyStr: PAnsiChar; cchCurrency: Integer): Integer; stdcall; external cLibName name 'GetCurrencyFormatA';
function GetCurrencyFormatW(Locale: LCID; dwFlags: DWORD; lpValue: PWideChar; lpFormat: PCurrencyFmtW; lpCurrencyStr: PWideChar; cchCurrency: Integer): Integer; stdcall; external cLibName name 'GetCurrencyFormatW';
function GetCurrentDirectory(nBufferLength: DWORD; lpBuffer: PAnsiChar): DWORD; stdcall; external cLibName name 'GetCurrentDirectoryA';
function GetCurrentDirectoryW(nBufferLength: DWORD; lpBuffer: PWideChar): DWORD; stdcall; external cLibName name 'GetCurrentDirectoryW';
function GetCurrentProcess: THandle; stdcall; external cLibName name 'GetCurrentProcess';
function GetCurrentProcessId: DWORD; stdcall; external cLibName name 'GetCurrentProcessId';
function GetCurrentThread: THandle; stdcall; external cLibName name 'GetCurrentThread';
function GetCurrentThreadId: DWORD; stdcall; external cLibName name 'GetCurrentThreadId';
function GetDateFormat(Locale: LCID; dwFlags: DWORD; lpDate: PSystemTime; lpFormat: PAnsiChar; lpDateStr: PAnsiChar; cchDate: Integer): Integer; stdcall; external cLibName name 'GetDateFormatA';
function GetDateFormatW(Locale: LCID; dwFlags: DWORD; lpDate: PSystemTime; lpFormat: PWideChar; lpDateStr: PWideChar; cchDate: Integer): Integer; stdcall; external cLibName name 'GetDateFormatW';
function GetDefaultCommConfig(lpszName: PAnsiChar; var lpCC: TCommConfig; var lpdwSize: DWORD): BOOL; stdcall; external cLibName name 'GetDefaultCommConfigA';
function GetDefaultCommConfigW(lpszName: PWideChar; var lpCC: TCommConfig; var lpdwSize: DWORD): BOOL; stdcall; external cLibName name 'GetDefaultCommConfigW';
function GetDiskFreeSpace(lpRootPathName: PAnsiChar; var lpSectorsPerCluster, lpBytesPerSector, lpNumberOfFreeClusters, lpTotalNumberOfClusters: DWORD): BOOL; stdcall; external cLibName name 'GetDiskFreeSpaceA';
function GetDiskFreeSpaceEx(lpDirectoryName: PAnsiChar; var lpFreeBytesAvailableToCaller, lpTotalNumberOfBytes; lpTotalNumberOfFreeBytes: PLargeInteger): BOOL; stdcall; external cLibName name 'GetDiskFreeSpaceExA';
function GetDiskFreeSpaceExW(lpDirectoryName: PWideChar; var lpFreeBytesAvailableToCaller, lpTotalNumberOfBytes; lpTotalNumberOfFreeBytes: PLargeInteger): BOOL; stdcall; external cLibName name 'GetDiskFreeSpaceExW';
function GetDiskFreeSpaceW(lpRootPathName: PWideChar; var lpSectorsPerCluster, lpBytesPerSector, lpNumberOfFreeClusters, lpTotalNumberOfClusters: DWORD): BOOL; stdcall; external cLibName name 'GetDiskFreeSpaceW';
function GetDriveType(lpRootPathName: PAnsiChar): UINT; stdcall; external cLibName name 'GetDriveTypeA';
function GetDriveTypeW(lpRootPathName: PWideChar): UINT; stdcall; external cLibName name 'GetDriveTypeW';
function GetEnvironmentStrings: PAnsiChar; stdcall; external cLibName name 'GetEnvironmentStringsA';
function GetEnvironmentStringsW: PWideChar; stdcall; external cLibName name 'GetEnvironmentStringsW';
function GetEnvironmentVariable(lpName: PAnsiChar; lpBuffer: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetEnvironmentVariableA';
function GetEnvironmentVariableW(lpName: PWideChar; lpBuffer: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetEnvironmentVariableW';
function GetExitCodeProcess(hProcess: THandle; var lpExitCode: DWORD): BOOL; stdcall; external cLibName name 'GetExitCodeProcess';
function GetExitCodeThread(hThread: THandle; var lpExitCode: DWORD): BOOL; stdcall; external cLibName name 'GetExitCodeThread';
function GetFileAttributes(lpFileName: PAnsiChar): DWORD; stdcall; external cLibName name 'GetFileAttributesA';
function GetFileAttributesEx(lpFileName: PAnsiChar; fInfoLevelId: TGetFileExInfoLevels; lpFileInformation: Pointer): BOOL; stdcall; external cLibName name 'GetFileAttributesExA';
function GetFileAttributesExW(lpFileName: PWideChar; fInfoLevelId: TGetFileExInfoLevels; lpFileInformation: Pointer): BOOL; stdcall; external cLibName name 'GetFileAttributesExW';
function GetFileAttributesW(lpFileName: PWideChar): DWORD; stdcall; external cLibName name 'GetFileAttributesW';
function GetFileInformationByHandle(hFile: THandle; var lpFileInformation: TByHandleFileInformation): BOOL; stdcall; external cLibName name 'GetFileInformationByHandle';
function GetFileSize(hFile: THandle; lpFileSizeHigh: Pointer): DWORD; stdcall; external cLibName name 'GetFileSize';
function GetFileTime(hFile: THandle; lpCreationTime, lpLastAccessTime, lpLastWriteTime: PFileTime): BOOL; stdcall; external cLibName name 'GetFileTime';
function GetFileType(hFile: THandle): DWORD; stdcall; external cLibName name 'GetFileType';
function GetFullPathName(lpFileName: PAnsiChar; nBufferLength: DWORD; lpBuffer: PAnsiChar; var lpFilePart: PAnsiChar): DWORD; stdcall; external cLibName name 'GetFullPathNameA';
function GetFullPathNameW(lpFileName: PWideChar; nBufferLength: DWORD; lpBuffer: PWideChar; var lpFilePart: PWideChar): DWORD; stdcall; external cLibName name 'GetFullPathNameW';
function GetHandleInformation(hObject: THandle; var lpdwFlags: DWORD): BOOL; stdcall; external cLibName name 'GetHandleInformation';
function GetLargestConsoleWindowSize(hConsoleOutput: THandle): TCoord; stdcall; external cLibName name 'GetLargestConsoleWindowSize';
function GetLastError: DWORD; stdcall; external cLibName name 'GetLastError';
procedure GetLocalTime(var lpSystemTime: TSystemTime); stdcall; external cLibName name 'GetLocalTime';
function GetLocaleInfo(Locale: LCID; LCType: LCTYPE; lpLCData: PAnsiChar; cchData: Integer): Integer; stdcall; external cLibName name 'GetLocaleInfoA';
function GetLocaleInfoW(Locale: LCID; LCType: LCTYPE; lpLCData: PWideChar; cchData: Integer): Integer; stdcall; external cLibName name 'GetLocaleInfoW';
function GetLogicalDriveStrings(nBufferLength: DWORD; lpBuffer: PAnsiChar): DWORD; stdcall; external cLibName name 'GetLogicalDriveStringsA';
function GetLogicalDriveStringsW(nBufferLength: DWORD; lpBuffer: PAnsiChar): DWORD; stdcall; external cLibName name 'GetLogicalDriveStringsW';
function GetLogicalDrives: DWORD; stdcall; external cLibName name 'GetLogicalDrives';
function GetMailslotInfo(hMailslot: THandle; lpMaxMessageSize: Pointer; var lpNextSize: DWORD; lpMessageCount, lpReadTimeout: Pointer): BOOL; stdcall; external cLibName name 'GetMailslotInfo';
function GetModuleFileName(hModule: THINST; lpFilename: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetModuleFileNameA';
function GetModuleFileNameW(hModule: THINST; lpFilename: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetModuleFileNameW';
function GetModuleHandle(lpModuleName: PAnsiChar): HMODULE; stdcall; external cLibName name 'GetModuleHandleA';
function GetModuleHandleW(lpModuleName: PWideChar): HMODULE; stdcall; external cLibName name 'GetModuleHandleW';
function GetNamedPipeHandleState(hNamedPipe: THandle; lpState, lpCurInstances, lpMaxCollectionCount, lpCollectDataTimeout: PDWORD; lpUserName: PAnsiChar; nMaxUserNameSize: DWORD): BOOL; stdcall; external cLibName name 'GetNamedPipeHandleStateA';
function GetNamedPipeHandleStateW(hNamedPipe: THandle; lpState, lpCurInstances, lpMaxCollectionCount, lpCollectDataTimeout: PDWORD; lpUserName: PWideChar; nMaxUserNameSize: DWORD): BOOL; stdcall; external cLibName name 'GetNamedPipeHandleStateW';
function GetNamedPipeInfo(hNamedPipe: THandle; var lpFlags: DWORD; lpOutBufferSize, lpInBufferSize, lpMaxInstances: Pointer): BOOL; stdcall; external cLibName name 'GetNamedPipeInfo';
function GetNumberFormat(Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar; lpFormat: PNumberFmtA; lpNumberStr: PAnsiChar; cchNumber: Integer): Integer; stdcall; external cLibName name 'GetNumberFormatA';
function GetNumberFormatW(Locale: LCID; dwFlags: DWORD; lpValue: PWideChar; lpFormat: PNumberFmtW; lpNumberStr: PWideChar; cchNumber: Integer): Integer; stdcall; external cLibName name 'GetNumberFormatW';
function GetNumberOfConsoleInputEvents(hConsoleInput: THandle; var lpNumberOfEvents: DWORD): BOOL; stdcall; external cLibName name 'GetNumberOfConsoleInputEvents';
function GetNumberOfConsoleMouseButtons(var lpNumberOfMouseButtons: DWORD): BOOL; stdcall; external cLibName name 'GetNumberOfConsoleMouseButtons';
function GetOEMCP: UINT; stdcall; external cLibName name 'GetOEMCP';
function GetOverlappedResult(hFile: THandle; const lpOverlapped: TOverlapped; var lpNumberOfBytesTransferred: DWORD; bWait: BOOL): BOOL; stdcall; external cLibName name 'GetOverlappedResult';
function GetPriorityClass(hProcess: THandle): DWORD; stdcall; external cLibName name 'GetPriorityClass';
function GetPrivateProfileInt(lpAppName, lpKeyName: PAnsiChar; nDefault: Integer; lpFileName: PAnsiChar): UINT; stdcall; external cLibName name 'GetPrivateProfileIntA';
function GetPrivateProfileIntW(lpAppName, lpKeyName: PWideChar; nDefault: Integer; lpFileName: PWideChar): UINT; stdcall; external cLibName name 'GetPrivateProfileIntW';
function GetPrivateProfileSection(lpAppName: PAnsiChar; lpReturnedString: PAnsiChar; nSize: DWORD; lpFileName: PAnsiChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileSectionA';
function GetPrivateProfileSectionNames(lpszReturnBuffer: PAnsiChar; nSize: DWORD; lpFileName: PAnsiChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileSectionNamesA';
function GetPrivateProfileSectionNamesW(lpszReturnBuffer: PWideChar; nSize: DWORD; lpFileName: PWideChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileSectionNamesW';
function GetPrivateProfileSectionW(lpAppName: PWideChar; lpReturnedString: PWideChar; nSize: DWORD; lpFileName: PWideChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileSectionW';
function GetPrivateProfileString(lpAppName, lpKeyName, lpDefault: PAnsiChar; lpReturnedString: PAnsiChar; nSize: DWORD; lpFileName: PAnsiChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileStringA';
function GetPrivateProfileStringW(lpAppName, lpKeyName, lpDefault: PWideChar; lpReturnedString: PWideChar; nSize: DWORD; lpFileName: PWideChar): DWORD; stdcall; external cLibName name 'GetPrivateProfileStringW';
function GetPrivateProfileStruct(lpszSection, lpszKey: PAnsiChar; lpStruct: Pointer; uSizeStruct: UINT; szFile: PAnsiChar): BOOL; stdcall; external cLibName name 'GetPrivateProfileStructA';
function GetPrivateProfileStructW(lpszSection, lpszKey: PWideChar; lpStruct: Pointer; uSizeStruct: UINT; szFile: PWideChar): BOOL; stdcall; external cLibName name 'GetPrivateProfileStructW';
function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): pointer; stdcall; external cLibName name 'GetProcAddress';
function GetProcessAffinityMask(hProcess: THandle; var lpProcessAffinityMask, lpSystemAffinityMask: nativeuint): BOOL; stdcall; external cLibName name 'GetProcessAffinityMask';
function GetProcessHeap: THandle; stdcall; external cLibName name 'GetProcessHeap';
function GetProcessHeaps(NumberOfHeaps: DWORD; var ProcessHeaps: THandle): DWORD; stdcall; external cLibName name 'GetProcessHeaps';
function GetProcessPriorityBoost(hThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall; external cLibName name 'GetProcessPriorityBoost';
function GetProcessShutdownParameters(var lpdwLevel, lpdwFlags: DWORD): BOOL; stdcall; external cLibName name 'GetProcessShutdownParameters';
function GetProcessTimes(hProcess: THandle; var lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall; external cLibName name 'GetProcessTimes';
function GetProcessVersion(ProcessId: DWORD): DWORD; stdcall; external cLibName name 'GetProcessVersion';
function GetProcessWorkingSetSize(hProcess: THandle; var lpMinimumWorkingSetSize, lpMaximumWorkingSetSize: DWORD): BOOL; stdcall; external cLibName name 'GetProcessWorkingSetSize';
function GetProfileInt(lpAppName, lpKeyName: PAnsiChar; nDefault: Integer): UINT; stdcall; external cLibName name 'GetProfileIntA';
function GetProfileIntW(lpAppName, lpKeyName: PWideChar; nDefault: Integer): UINT; stdcall; external cLibName name 'GetProfileIntW';
function GetProfileSection(lpAppName: PAnsiChar; lpReturnedString: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetProfileSectionA';
function GetProfileSectionW(lpAppName: PWideChar; lpReturnedString: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetProfileSectionW';
function GetProfileString(lpAppName, lpKeyName, lpDefault: PAnsiChar; lpReturnedString: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetProfileStringA';
function GetProfileStringW(lpAppName, lpKeyName, lpDefault: PWideChar; lpReturnedString: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'GetProfileStringW';
function GetQueuedCompletionStatus(CompletionPort: THandle; var lpNumberOfBytesTransferred, lpCompletionKey: DWORD; var lpOverlapped: POverlapped; dwMilliseconds: DWORD): BOOL; stdcall; external cLibName name 'GetQueuedCompletionStatus';
function GetShortPathName(lpszLongPath: PAnsiChar; lpszShortPath: PAnsiChar; cchBuffer: DWORD): DWORD; stdcall; external cLibName name 'GetShortPathNameA';
function GetShortPathNameW(lpszLongPath: PWideChar; lpszShortPath: PWideChar; cchBuffer: DWORD): DWORD; stdcall; external cLibName name 'GetShortPathNameW';
procedure GetStartupInfo(var lpStartupInfo: TStartupInfoA); stdcall; external cLibName name 'GetStartupInfoA';
procedure GetStartupInfoW(var lpStartupInfo: TStartupInfoW); stdcall; external cLibName name 'GetStartupInfoW';
function GetStdHandle(nStdHandle: DWORD): THandle; stdcall; external cLibName name 'GetStdHandle';
function GetStringTypeA(Locale: LCID; dwInfoType: DWORD; const lpSrcStr: LPCSTR; cchSrc: BOOL; var lpCharType: Word): BOOL; external cLibName name 'GetStringTypeA';
function GetStringTypeEx(Locale: LCID; dwInfoType: DWORD; lpSrcStr: PAnsiChar; cchSrc: Integer; var lpCharType): BOOL; stdcall; external cLibName name 'GetStringTypeExA';
function GetStringTypeExW(Locale: LCID; dwInfoType: DWORD; lpSrcStr: PWideChar; cchSrc: Integer; var lpCharType): BOOL; stdcall; external cLibName name 'GetStringTypeExW';
function GetStringTypeW(dwInfoType: DWORD; const lpSrcStr: WideChar; cchSrc: BOOL; var lpCharType: Word): BOOL; external cLibName name 'GetStringTypeW';
function GetSystemDefaultLCID: LCID; stdcall; external cLibName name 'GetSystemDefaultLCID';
function GetSystemDefaultLangID: LANGID; stdcall; external cLibName name 'GetSystemDefaultLangID';
function GetSystemDirectory(lpBuffer: PAnsiChar; uSize: UINT): UINT; stdcall; external cLibName name 'GetSystemDirectoryA';
function GetSystemDirectoryW(lpBuffer: PWideChar; uSize: UINT): UINT; stdcall; external cLibName name 'GetSystemDirectoryW';
procedure GetSystemInfo(var lpSystemInfo: TSystemInfo); stdcall; external cLibName name 'GetSystemInfo';
function GetSystemPowerStatus(var lpSystemPowerStatus: TSystemPowerStatus): BOOL; stdcall; external cLibName name 'GetSystemPowerStatus';
procedure GetSystemTime(var lpSystemTime: TSystemTime); stdcall; external cLibName name 'GetSystemTime';
function GetSystemTimeAdjustment(var lpTimeAdjustment, lpTimeIncrement: DWORD; var lpTimeAdjustmentDisabled: BOOL): BOOL; stdcall; external cLibName name 'GetSystemTimeAdjustment';
procedure GetSystemTimeAsFileTime(var lpSystemTimeAsFileTime: TFileTime); stdcall; external cLibName name 'GetSystemTimeAsFileTime';
function GetTapeParameters(hDevice: THandle; dwOperation: DWORD; var lpdwSize: DWORD; lpTapeInformation: Pointer): DWORD; stdcall; external cLibName name 'GetTapeParameters';
function GetTapePosition(hDevice: THandle; dwPositionType: DWORD; var lpdwPartition, lpdwOffsetLow: DWORD; lpdwOffsetHigh: Pointer): DWORD; stdcall; external cLibName name 'GetTapePosition';
function GetTapeStatus(hDevice: THandle): DWORD; stdcall; external cLibName name 'GetTapeStatus';
function GetTempFileName(lpPathName, lpPrefixString: PAnsiChar; uUnique: UINT; lpTempFileName: PAnsiChar): UINT; stdcall; external cLibName name 'GetTempFileNameA';
function GetTempFileNameW(lpPathName, lpPrefixString: PWideChar; uUnique: UINT; lpTempFileName: PWideChar): UINT; stdcall; external cLibName name 'GetTempFileNameW';
function GetTempPath(nBufferLength: DWORD; lpBuffer: PAnsiChar): DWORD; stdcall; external cLibName name 'GetTempPathA';
function GetTempPathW(nBufferLength: DWORD; lpBuffer: PWideChar): DWORD; stdcall; external cLibName name 'GetTempPathW';
function GetThreadContext(hThread: THandle; var lpContext: TContext): BOOL; stdcall; external cLibName name 'GetThreadContext';
function GetThreadLocale: LCID; stdcall; external cLibName name 'GetThreadLocale';
function GetThreadPriority(hThread: THandle): Integer; stdcall; external cLibName name 'GetThreadPriority';
function GetThreadPriorityBoost(hThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall; external cLibName name 'GetThreadPriorityBoost';
function GetThreadSelectorEntry(hThread: THandle; dwSelector: DWORD; var lpSelectorEntry: TLDTEntry): BOOL; stdcall; external cLibName name 'GetThreadSelectorEntry';
function GetThreadTimes(hThread: THandle; var lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall; external cLibName name 'GetThreadTimes';
function GetTickCount: DWORD; stdcall; external cLibName name 'GetTickCount';
function GetTimeFormat(Locale: LCID; dwFlags: DWORD; lpTime: PSystemTime; lpFormat: PAnsiChar; lpTimeStr: PAnsiChar; cchTime: Integer): Integer; stdcall; external cLibName name 'GetTimeFormatA';
function GetTimeFormatW(Locale: LCID; dwFlags: DWORD; lpTime: PSystemTime; lpFormat: PWideChar; lpTimeStr: PWideChar; cchTime: Integer): Integer; stdcall; external cLibName name 'GetTimeFormatW';
function GetTimeZoneInformation(var lpTimeZoneInformation: TTimeZoneInformation): DWORD; stdcall; external cLibName name 'GetTimeZoneInformation';
function GetUserDefaultLCID: LCID; stdcall; external cLibName name 'GetUserDefaultLCID';
function GetUserDefaultLangID: LANGID; stdcall; external cLibName name 'GetUserDefaultLangID';
function GetVersion: DWORD; stdcall; external cLibName name 'GetVersion';
function GetVersionEx(var lpVersionInformation: TOSVersionInfoA): BOOL; stdcall; external cLibName name 'GetVersionExA';
function GetVersionExW(var lpVersionInformation: TOSVersionInfoW): BOOL; stdcall; external cLibName name 'GetVersionExW';
function GetVolumeInformation(lpRootPathName: PAnsiChar; lpVolumeNameBuffer: PAnsiChar; nVolumeNameSize: DWORD; lpVolumeSerialNumber: PDWORD; var lpMaximumComponentLength, lpFileSystemFlags: DWORD; lpFileSystemNameBuffer: PAnsiChar; nFileSystemNameSize: DWORD): BOOL; stdcall; external cLibName name 'GetVolumeInformationA';
function GetVolumeInformationW(lpRootPathName: PWideChar; lpVolumeNameBuffer: PWideChar; nVolumeNameSize: DWORD; lpVolumeSerialNumber: PDWORD; var lpMaximumComponentLength, lpFileSystemFlags: DWORD; lpFileSystemNameBuffer: PWideChar; nFileSystemNameSize: DWORD): BOOL; stdcall; external cLibName name 'GetVolumeInformationW';
function GetWindowsDirectory(lpBuffer: PAnsiChar; uSize: UINT): UINT; stdcall; external cLibName name 'GetWindowsDirectoryA';
function GetWindowsDirectoryW(lpBuffer: PWideChar; uSize: UINT): UINT; stdcall; external cLibName name 'GetWindowsDirectoryW';
function GlobalAddAtom(lpString: PAnsiChar): TATOM; stdcall; external cLibName name 'GlobalAddAtomA';
function GlobalAddAtomW(lpString: PWideChar): TATOM; stdcall; external cLibName name 'GlobalAddAtomW';
function GlobalAlloc(uFlags: UINT; dwBytes: DWORD): HGLOBAL; stdcall; external cLibName name 'GlobalAlloc';
function GlobalCompact(dwMinFree: DWORD): UINT; stdcall; external cLibName name 'GlobalCompact';
function GlobalDeleteAtom(nAtom: TATOM): TATOM; stdcall; external cLibName name 'GlobalDeleteAtom';
function GlobalFindAtom(lpString: PAnsiChar): TATOM; stdcall; external cLibName name 'GlobalFindAtomA';
function GlobalFindAtomW(lpString: PWideChar): TATOM; stdcall; external cLibName name 'GlobalFindAtomW';
procedure GlobalFix(hMem: HGLOBAL); stdcall; external cLibName name 'GlobalFix';
function GlobalFlags(hMem: HGLOBAL): UINT; stdcall; external cLibName name 'GlobalFlags';
function GlobalFree(hMem: HGLOBAL): HGLOBAL; stdcall; external cLibName name 'GlobalFree';
function GlobalGetAtomName(nAtom: TATOM; lpBuffer: PAnsiChar; nSize: Integer): UINT; stdcall; external cLibName name 'GlobalGetAtomNameA';
function GlobalGetAtomNameW(nAtom: TATOM; lpBuffer: PWideChar; nSize: Integer): UINT; stdcall; external cLibName name 'GlobalGetAtomNameW';
function GlobalHandle(Mem: Pointer): HGLOBAL; stdcall; external cLibName name 'GlobalHandle';
function GlobalLock(hMem: HGLOBAL): Pointer; stdcall; external cLibName name 'GlobalLock';
procedure GlobalMemoryStatus(var lpBuffer: TMemoryStatus); stdcall; external cLibName name 'GlobalMemoryStatus';
function GlobalReAlloc(hMem: HGLOBAL; dwBytes: DWORD; uFlags: UINT): HGLOBAL; stdcall; external cLibName name 'GlobalReAlloc';
function GlobalSize(hMem: HGLOBAL): DWORD; stdcall; external cLibName name 'GlobalSize';
function GlobalUnWire(hMem: HGLOBAL): BOOL; stdcall; external cLibName name 'GlobalUnWire';
procedure GlobalUnfix(hMem: HGLOBAL); stdcall; external cLibName name 'GlobalUnfix';
function GlobalUnlock(hMem: HGLOBAL): BOOL; stdcall; external cLibName name 'GlobalUnlock';
function GlobalWire(hMem: HGLOBAL): Pointer; stdcall; external cLibName name 'GlobalWire';
function Heap32First(var lphe: THeapEntry32; th32ProcessID, th32HeapID: DWORD): BOOL; stdcall; external cLibName name 'Heap32First';
function Heap32ListFirst(hSnapshot: THandle; var lphl: THeapList32): BOOL; stdcall; external cLibName name 'Heap32ListFirst';
function Heap32ListNext(hSnapshot: THandle; var lphl: THeapList32): BOOL; stdcall; external cLibName name 'Heap32ListNext';
function Heap32Next(var lphe: THeapEntry32): BOOL; stdcall; external cLibName name 'Heap32Next';
function HeapAlloc(hHeap: THandle; dwFlags, dwBytes: DWORD): Pointer; stdcall; external cLibName name 'HeapAlloc';
function HeapCompact(hHeap: THandle; dwFlags: DWORD): UINT; stdcall; external cLibName name 'HeapCompact';
function HeapCreate(flOptions, dwInitialSize, dwMaximumSize: DWORD): THandle; stdcall; external cLibName name 'HeapCreate';
function HeapDestroy(hHeap: THandle): BOOL; stdcall; external cLibName name 'HeapDestroy';
function HeapFree(hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall; external cLibName name 'HeapFree';
function HeapLock(hHeap: THandle): BOOL; stdcall; external cLibName name 'HeapLock';
function HeapReAlloc(hHeap: THandle; dwFlags: DWORD; lpMem: Pointer; dwBytes: DWORD): Pointer; stdcall; external cLibName name 'HeapReAlloc';
function HeapSize(hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): DWORD; stdcall; external cLibName name 'HeapSize';
function HeapUnlock(hHeap: THandle): BOOL; stdcall; external cLibName name 'HeapUnlock';
function HeapValidate(hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall; external cLibName name 'HeapValidate';
function HeapWalk(hHeap: THandle; var lpEntry: TProcessHeapEntry): BOOL; stdcall; external cLibName name 'HeapWalk';
function InitAtomTable(nSize: DWORD): BOOL; stdcall; external cLibName name 'InitAtomTable';
procedure InitializeCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external cLibName name 'InitializeCriticalSection';
function InitializeCriticalSectionAndSpinCount(var lpCriticalSection: TRTLCriticalSection; dwSpinCount: DWORD): BOOL; stdcall; external cLibName name 'InitializeCriticalSectionAndSpinCount';
function InterlockedCompareExchange(var Destination: Pointer; Exchange: Pointer; Comperand: Pointer): Pointer; stdcall; external cLibName name 'InterlockedCompareExchange';
function InterlockedDecrement(var Addend: Integer): Integer; stdcall; external cLibName name 'InterlockedDecrement';
function InterlockedExchange(var Target: Integer; Value: Integer): Integer; stdcall; external cLibName name 'InterlockedExchange';
function InterlockedExchangeAdd(Addend: PLongint; Value: Longint): Longint; stdcall; external cLibName name 'InterlockedExchangeAdd';
function InterlockedIncrement(var Addend: Integer): Integer; stdcall; external cLibName name 'InterlockedIncrement';
function IsBadCodePtr(lpfn: Pointer): BOOL; stdcall; external cLibName name 'IsBadCodePtr';
function IsBadHugeReadPtr(lp: Pointer; ucb: UINT): BOOL; stdcall; external cLibName name 'IsBadHugeReadPtr';
function IsBadHugeWritePtr(lp: Pointer; ucb: UINT): BOOL; stdcall; external cLibName name 'IsBadHugeWritePtr';
function IsBadReadPtr(lp: Pointer; ucb: UINT): BOOL; stdcall; external cLibName name 'IsBadReadPtr';
function IsBadStringPtr(lpsz: PAnsiChar; ucchMax: UINT): BOOL; stdcall; external cLibName name 'IsBadStringPtrA';
function IsBadStringPtrW(lpsz: PWideChar; ucchMax: UINT): BOOL; stdcall; external cLibName name 'IsBadStringPtrW';
function IsBadWritePtr(lp: Pointer; ucb: UINT): BOOL; stdcall; external cLibName name 'IsBadWritePtr';
function IsDBCSLeadByte(TestChar: Byte): BOOL; stdcall; external cLibName name 'IsDBCSLeadByte';
function IsDBCSLeadByteEx(CodePage: UINT; TestChar: Byte): BOOL; stdcall; external cLibName name 'IsDBCSLeadByteEx';
function IsProcessorFeaturePresent(ProcessorFeature: DWORD): BOOL; stdcall; external cLibName name 'IsProcessorFeaturePresent';
function IsValidCodePage(CodePage: UINT): BOOL; stdcall; external cLibName name 'IsValidCodePage';
function IsValidLocale(Locale: LCID; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'IsValidLocale';
function LCMapString(Locale: LCID; dwMapFlags: DWORD; lpSrcStr: PAnsiChar; cchSrc: Integer; lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall; external cLibName name 'LCMapStringA';
function LCMapStringW(Locale: LCID; dwMapFlags: DWORD; lpSrcStr: PWideChar; cchSrc: Integer; lpDestStr: PWideChar; cchDest: Integer): Integer; stdcall; external cLibName name 'LCMapStringW';
procedure LeaveCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external cLibName name 'LeaveCriticalSection';
function LoadLibrary(lpLibFileName: PAnsiChar): HMODULE; stdcall; external cLibName name 'LoadLibraryA';
function LoadLibraryEx(lpLibFileName: PAnsiChar; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall; external cLibName name 'LoadLibraryExA';
function LoadLibraryExW(lpLibFileName: PWideChar; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall; external cLibName name 'LoadLibraryExW';
function LoadLibraryW(lpLibFileName: PWideChar): HMODULE; stdcall; external cLibName name 'LoadLibraryW';
function LoadModule(lpModuleName: LPCSTR; lpParameterBlock: Pointer): DWORD; stdcall; external cLibName name 'LoadModule';
function LoadResource(hModule: THINST; hResInfo: THRSRC): HGLOBAL; stdcall; external cLibName name 'LoadResource';
function LocalAlloc(uFlags, uBytes: UINT): THLOCAL; stdcall; external cLibName name 'LocalAlloc';
function LocalCompact(uMinFree: UINT): UINT; stdcall; external cLibName name 'LocalCompact';
function LocalFileTimeToFileTime(const lpLocalFileTime: TFileTime; var lpFileTime: TFileTime): BOOL; stdcall; external cLibName name 'LocalFileTimeToFileTime';
function LocalFlags(hMem: THLOCAL): UINT; stdcall; external cLibName name 'LocalFlags';
function LocalFree(hMem: THLOCAL): THLOCAL; stdcall; external cLibName name 'LocalFree';
function LocalLock(hMem: THLOCAL): Pointer; stdcall; external cLibName name 'LocalLock';
function LocalReAlloc(hMem: THLOCAL; uBytes, uFlags: UINT): THLOCAL; stdcall; external cLibName name 'LocalReAlloc';
function LocalShrink(hMem: THLOCAL; cbNewSize: UINT): UINT; stdcall; external cLibName name 'LocalShrink';
function LocalSize(hMem: THLOCAL): UINT; stdcall; external cLibName name 'LocalSize';
function LocalUnlock(hMem: THLOCAL): BOOL; stdcall; external cLibName name 'LocalUnlock';
function LockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToLockLow, nNumberOfBytesToLockHigh: DWORD): BOOL; stdcall; external cLibName name 'LockFile';
function LockFileEx(hFile: THandle; dwFlags, dwReserved: DWORD; nNumberOfBytesToLockLow, nNumberOfBytesToLockHigh: DWORD; const lpOverlapped: TOverlapped): BOOL; stdcall; external cLibName name 'LockFileEx';
function LockResource(hResData: HGLOBAL): Pointer; stdcall; external cLibName name 'LockResource';
function MapViewOfFile(hFileMappingObject: THandle; dwDesiredAccess: DWORD; dwFileOffsetHigh, dwFileOffsetLow, dwNumberOfBytesToMap: DWORD): Pointer; stdcall; external cLibName name 'MapViewOfFile';
function MapViewOfFileEx(hFileMappingObject: THandle; dwDesiredAccess, dwFileOffsetHigh, dwFileOffsetLow, dwNumberOfBytesToMap: DWORD; lpBaseAddress: Pointer): Pointer; stdcall; external cLibName name 'MapViewOfFileEx';
function Module32First(hSnapshot: THandle; var lpme: TModuleEntry32A): BOOL; stdcall; external cLibName name 'Module32First';
function Module32Next(hSnapshot: THandle; var lpme: TModuleEntry32W): BOOL; stdcall; external cLibName name 'Module32Next';
function MoveFile(lpExistingFileName, lpNewFileName: PAnsiChar): BOOL; stdcall; external cLibName name 'MoveFileA';
function MoveFileEx(lpExistingFileName, lpNewFileName: PAnsiChar; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'MoveFileExA';
function MoveFileExW(lpExistingFileName, lpNewFileName: PWideChar; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'MoveFileExW';
function MoveFileW(lpExistingFileName, lpNewFileName: PWideChar): BOOL; stdcall; external cLibName name 'MoveFileW';
function MoveFileWithProgress(lpExistingFileName, lpNewFileName: PAnsiChar; lpProgressRoutine: TCopyProgressRoutine; lpData: Pointer; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'MoveFileWithProgressA';
function MoveFileWithProgressW(lpExistingFileName, lpNewFileName: PWideChar; lpProgressRoutine: TCopyProgressRoutine; lpData: Pointer; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'MoveFileWithProgressW';
function MulDiv(nNumber, nNumerator, nDenominator: Integer): Integer; stdcall; external cLibName name 'MulDiv';
function MultiByteToWideChar(CodePage: UINT; dwFlags: DWORD; const lpMultiByteStr: LPCSTR; cchMultiByte: Integer; lpWideCharStr: LPWSTR; cchWideChar: Integer): Integer; stdcall; external cLibName name 'MultiByteToWideChar';
function OpenEvent(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenEventA';
function OpenEventW(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'OpenEventW';
function OpenFile(const lpFileName: LPCSTR; var lpReOpenBuff: TOFStruct; uStyle: UINT): THFILE; stdcall; external cLibName name 'OpenFile';
function OpenFileMapping(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenFileMappingA';
function OpenFileMappingW(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'OpenFileMappingW';
function OpenMutex(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenMutexA';
function OpenMutexW(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'OpenMutexW';
function OpenProcess(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall; external cLibName name 'OpenProcess';
function OpenSemaphore(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenSemaphoreA';
function OpenSemaphoreW(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PWideChar): THandle; stdcall; external cLibName name 'OpenSemaphoreW';
function OpenWaitableTimer(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpTimerName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenWaitableTimerA';
function OpenWaitableTimerW(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpTimerName: PWideChar): THandle; stdcall; external cLibName name 'OpenWaitableTimerW';
procedure OutputDebugString(lpOutputString: PAnsiChar); stdcall; external cLibName name 'OutputDebugStringA';
procedure OutputDebugStringW(lpOutputString: PWideChar); stdcall; external cLibName name 'OutputDebugStringW';
function PeekConsoleInput(hConsoleInput: THandle; var lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsRead: DWORD): BOOL; stdcall; external cLibName name 'PeekConsoleInputA';
function PeekConsoleInputW(hConsoleInput: THandle; var lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsRead: DWORD): BOOL; stdcall; external cLibName name 'PeekConsoleInputW';
function PeekNamedPipe(hNamedPipe: THandle; lpBuffer: Pointer; nBufferSize: DWORD; lpBytesRead, lpTotalBytesAvail, lpBytesLeftThisMessage: Pointer): BOOL; stdcall; external cLibName name 'PeekNamedPipe';
function PostQueuedCompletionStatus(CompletionPort: THandle; dwNumberOfBytesTransferred: DWORD; dwCompletionKey: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'PostQueuedCompletionStatus';
function PrepareTape(hDevice: THandle; dwOperation: DWORD; bImmediate: BOOL): DWORD; stdcall; external cLibName name 'PrepareTape';
function Process32First(hSnapshot: THandle; var lppe: TProcessEntry32W): BOOL; stdcall; external cLibName name 'Process32First';
function Process32Next(hSnapshot: THandle; var lppe: TProcessEntry32W): BOOL; stdcall; external cLibName name 'Process32Next';
function PulseEvent(hEvent: THandle): BOOL; stdcall; external cLibName name 'PulseEvent';
function PurgeComm(hFile: THandle; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'PurgeComm';
function QueryDosDevice(lpDeviceName: PAnsiChar; lpTargetPath: PAnsiChar; ucchMax: DWORD): DWORD; stdcall; external cLibName name 'QueryDosDeviceA';
function QueryDosDeviceW(lpDeviceName: PWideChar; lpTargetPath: PWideChar; ucchMax: DWORD): DWORD; stdcall; external cLibName name 'QueryDosDeviceW';
function QueryPerformanceCounter(var lpPerformanceCount: TLargeInteger): BOOL; stdcall; external cLibName name 'QueryPerformanceCounter';
function QueryPerformanceFrequency(var lpFrequency: TLargeInteger): BOOL; stdcall; external cLibName name 'QueryPerformanceFrequency';
function QueueUserAPC(pfnAPC: TAPCProc; hThread: THandle; dwData: DWORD): BOOL; stdcall; external cLibName name 'QueueUserAPC';
procedure RaiseException(dwExceptionCode, dwExceptionFlags, nNumberOfArguments: DWORD; lpArguments: PDWORD); stdcall; external cLibName name 'RaiseException';
function ReadConsole(hConsoleInput: THandle; lpBuffer: Pointer; nNumberOfCharsToRead: DWORD; var lpNumberOfCharsRead: DWORD; lpReserved: Pointer): BOOL; stdcall; external cLibName name 'ReadConsoleA';
function ReadConsoleInput(hConsoleInput: THandle; var lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsRead: DWORD): BOOL; stdcall; external cLibName name 'ReadConsoleInputA';
function ReadConsoleInputW(hConsoleInput: THandle; var lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsRead: DWORD): BOOL; stdcall; external cLibName name 'ReadConsoleInputW';
function ReadConsoleOutput(hConsoleOutput: THandle; lpBuffer: Pointer; dwBufferSize, dwBufferCoord: TCoord; var lpReadRegion: TSmallRect): BOOL; stdcall; external cLibName name 'ReadConsoleOutputA';
function ReadConsoleOutputAttribute(hConsoleOutput: THandle; lpAttribute: Pointer; nLength: DWORD; dwReadCoord: TCoord; var lpNumberOfAttrsRead: DWORD): BOOL; stdcall; external cLibName name 'ReadConsoleOutputAttribute';
function ReadConsoleOutputCharacter(hConsoleOutput: THandle; lpCharacter: PAnsiChar; nLength: DWORD; dwReadCoord: TCoord; var lpNumberOfCharsRead: DWORD): BOOL; stdcall; external cLibName name 'ReadConsoleOutputCharacterA';
function ReadConsoleOutputCharacterW(hConsoleOutput: THandle; lpCharacter: PAnsiChar; nLength: DWORD; dwReadCoord: TCoord; var lpNumberOfCharsRead: DWORD): BOOL; stdcall; external cLibName name 'ReadConsoleOutputCharacterW';
function ReadConsoleOutputW(hConsoleOutput: THandle; lpBuffer: Pointer; dwBufferSize, dwBufferCoord: TCoord; var lpReadRegion: TSmallRect): BOOL; stdcall; external cLibName name 'ReadConsoleOutputW';
function ReadConsoleW(hConsoleInput: THandle; lpBuffer: Pointer; nNumberOfCharsToRead: DWORD; var lpNumberOfCharsRead: DWORD; lpReserved: Pointer): BOOL; stdcall; external cLibName name 'ReadConsoleW';
function ReadDirectoryChangesW(hDirectory: THandle; lpBuffer: Pointer; nBufferLength: DWORD; bWatchSubtree: Bool; dwNotifyFilter: DWORD; lpBytesReturned: LPDWORD; lpOverlapped: POverlapped; lpCompletionRoutine: pointer): BOOL; stdcall; external cLibName name 'ReadDirectoryChangesW';
function ReadFile(hFile: THandle; var Buffer; nNumberOfBytesToRead: DWORD; var lpNumberOfBytesRead: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'ReadFile';
function ReadFileEx(hFile: THandle; lpBuffer: Pointer; nNumberOfBytesToRead: DWORD; lpOverlapped: POverlapped; lpCompletionRoutine: TFileIOCompletionRoutine): BOOL; stdcall; external cLibName name 'ReadFileEx';
function ReadProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer; nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall; external cLibName name 'ReadProcessMemory';
function ReleaseMutex(hMutex: THandle): BOOL; stdcall; external cLibName name 'ReleaseMutex';
function ReleaseSemaphore(hSemaphore: THandle; lReleaseCount: Longint; lpPreviousCount: Pointer): BOOL; stdcall; external cLibName name 'ReleaseSemaphore';
function RemoveDirectory(lpPathName: PAnsiChar): BOOL; stdcall; external cLibName name 'RemoveDirectoryA';
function RemoveDirectoryW(lpPathName: PWideChar): BOOL; stdcall; external cLibName name 'RemoveDirectoryW';
function ResetEvent(hEvent: THandle): BOOL; stdcall; external cLibName name 'ResetEvent';
function ResumeThread(hThread: THandle): DWORD; stdcall; external cLibName name 'ResumeThread';
function ScrollConsoleScreenBuffer(hConsoleOutput: THandle; const lpScrollRectangle: TSmallRect; lpClipRectangle: PSmallRect; dwDestinationOrigin: TCoord; var lpFill: TCharInfo): BOOL; stdcall; external cLibName name 'ScrollConsoleScreenBufferA';
function ScrollConsoleScreenBufferW(hConsoleOutput: THandle; const lpScrollRectangle: TSmallRect; lpClipRectangle: PSmallRect; dwDestinationOrigin: TCoord; var lpFill: TCharInfo): BOOL; stdcall; external cLibName name 'ScrollConsoleScreenBufferW';
function SearchPath(lpPath, lpFileName, lpExtension: PAnsiChar; nBufferLength: DWORD; lpBuffer: PAnsiChar; var lpFilePart: PAnsiChar): DWORD; stdcall; external cLibName name 'SearchPathA';
function SearchPathW(lpPath, lpFileName, lpExtension: PWideChar; nBufferLength: DWORD; lpBuffer: PWideChar; var lpFilePart: PWideChar): DWORD; stdcall; external cLibName name 'SearchPathW';
function SetCommBreak(hFile: THandle): BOOL; stdcall; external cLibName name 'SetCommBreak';
function SetCommConfig(hCommDev: THandle; const lpCC: TCommConfig; dwSize: DWORD): BOOL; stdcall; external cLibName name 'SetCommConfig';
function SetCommMask(hFile: THandle; dwEvtMask: DWORD): BOOL; stdcall; external cLibName name 'SetCommMask';
function SetCommState(hFile: THandle; const lpDCB: TDCB): BOOL; stdcall; external cLibName name 'SetCommState';
function SetCommTimeouts(hFile: THandle; const lpCommTimeouts: TCommTimeouts): BOOL; stdcall; external cLibName name 'SetCommTimeouts';
function SetComputerName(lpComputerName: PAnsiChar): BOOL; stdcall; external cLibName name 'SetComputerNameA';
function SetComputerNameW(lpComputerName: PWideChar): BOOL; stdcall; external cLibName name 'SetComputerNameW';
function SetConsoleActiveScreenBuffer(hConsoleOutput: THandle): BOOL; stdcall; external cLibName name 'SetConsoleActiveScreenBuffer';
function SetConsoleCP(wCodePageID: UINT): BOOL; stdcall; external cLibName name 'SetConsoleCP';
function SetConsoleCtrlHandler(HandlerRoutine: THandlerRoutine; Add: BOOL): BOOL; stdcall; external cLibName name 'SetConsoleCtrlHandler';
function SetConsoleCursorInfo(hConsoleOutput: THandle; const lpConsoleCursorInfo: TConsoleCursorInfo): BOOL; stdcall; external cLibName name 'SetConsoleCursorInfo';
function SetConsoleCursorPosition(hConsoleOutput: THandle; dwCursorPosition: TCoord): BOOL; stdcall; external cLibName name 'SetConsoleCursorPosition';
function SetConsoleMode(hConsoleHandle: THandle; dwMode: DWORD): BOOL; stdcall; external cLibName name 'SetConsoleMode';
function SetConsoleOutputCP(wCodePageID: UINT): BOOL; stdcall; external cLibName name 'SetConsoleOutputCP';
function SetConsoleScreenBufferSize(hConsoleOutput: THandle; dwSize: TCoord): BOOL; stdcall; external cLibName name 'SetConsoleScreenBufferSize';
function SetConsoleTextAttribute(hConsoleOutput: THandle; wAttributes: Word): BOOL; stdcall; external cLibName name 'SetConsoleTextAttribute';
function SetConsoleTitle(lpConsoleTitle: PAnsiChar): BOOL; stdcall; external cLibName name 'SetConsoleTitleA';
function SetConsoleTitleW(lpConsoleTitle: PWideChar): BOOL; stdcall; external cLibName name 'SetConsoleTitleW';
function SetConsoleWindowInfo(hConsoleOutput: THandle; bAbsolute: BOOL; const lpConsoleWindow: TSmallRect): BOOL; stdcall; external cLibName name 'SetConsoleWindowInfo';
function SetCriticalSectionSpinCount(var lpCriticalSection: TRTLCriticalSection; dwSpinCount: DWORD): DWORD; stdcall; external cLibName name 'SetCriticalSectionSpinCount';
function SetCurrentDirectory(lpPathName: PAnsiChar): BOOL; stdcall; external cLibName name 'SetCurrentDirectoryA';
function SetCurrentDirectoryW(lpPathName: PWideChar): BOOL; stdcall; external cLibName name 'SetCurrentDirectoryW';
function SetDefaultCommConfig(lpszName: PAnsiChar; lpCC: PCommConfigA; dwSize: DWORD): BOOL; stdcall; external cLibName name 'SetDefaultCommConfigA';
function SetDefaultCommConfigW(lpszName: PWideChar; lpCC: PCommConfigW; dwSize: DWORD): BOOL; stdcall; external cLibName name 'SetDefaultCommConfigW';
function SetEndOfFile(hFile: THandle): BOOL; stdcall; external cLibName name 'SetEndOfFile';
function SetEnvironmentVariable(lpName, lpValue: PAnsiChar): BOOL; stdcall; external cLibName name 'SetEnvironmentVariableA';
function SetEnvironmentVariableW(lpName, lpValue: PWideChar): BOOL; stdcall; external cLibName name 'SetEnvironmentVariableW';
function SetErrorMode(uMode: UINT): UINT; stdcall; external cLibName name 'SetErrorMode';
function SetEvent(hEvent: THandle): BOOL; stdcall; external cLibName name 'SetEvent';
procedure SetFileApisToANSI; stdcall; external cLibName name 'SetFileApisToANSI';
procedure SetFileApisToOEM; stdcall; external cLibName name 'SetFileApisToOEM';
function SetFileAttributes(lpFileName: PAnsiChar; dwFileAttributes: DWORD): BOOL; stdcall; external cLibName name 'SetFileAttributesA';
function SetFileAttributesW(lpFileName: PWideChar; dwFileAttributes: DWORD): BOOL; stdcall; external cLibName name 'SetFileAttributesW';
function SetFilePointer(hFile: THandle; lDistanceToMove: Longint; lpDistanceToMoveHigh: Pointer; dwMoveMethod: DWORD): DWORD; stdcall; external cLibName name 'SetFilePointer';
function SetFileTime(hFile: THandle; lpCreationTime, lpLastAccessTime, lpLastWriteTime: PFileTime): BOOL; stdcall; external cLibName name 'SetFileTime';
function SetHandleCount(uNumber: UINT): UINT; stdcall; external cLibName name 'SetHandleCount';
function SetHandleInformation(hObject: THandle; dwMask: DWORD; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'SetHandleInformation';
procedure SetLastError(dwErrCode: DWORD); stdcall; external cLibName name 'SetLastError';
function SetLocalTime(const lpSystemTime: TSystemTime): BOOL; stdcall; external cLibName name 'SetLocalTime';
function SetLocaleInfo(Locale: LCID; LCType: LCTYPE; lpLCData: PAnsiChar): BOOL; stdcall; external cLibName name 'SetLocaleInfoA';
function SetLocaleInfoW(Locale: LCID; LCType: LCTYPE; lpLCData: PWideChar): BOOL; stdcall; external cLibName name 'SetLocaleInfoW';
function SetMailslotInfo(hMailslot: THandle; lReadTimeout: DWORD): BOOL; stdcall; external cLibName name 'SetMailslotInfo';
function SetNamedPipeHandleState(hNamedPipe: THandle; var lpMode: DWORD; lpMaxCollectionCount, lpCollectDataTimeout: Pointer): BOOL; stdcall; external cLibName name 'SetNamedPipeHandleState';
function SetPriorityClass(hProcess: THandle; dwPriorityClass: DWORD): BOOL; stdcall; external cLibName name 'SetPriorityClass';
function SetProcessAffinityMask(hProcess: THandle; dwProcessAffinityMask: nativeuint): BOOL; stdcall; external cLibName name 'SetProcessAffinityMask';
function SetProcessPriorityBoost(hThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall; external cLibName name 'SetProcessPriorityBoost';
function SetProcessShutdownParameters(dwLevel, dwFlags: DWORD): BOOL; stdcall; external cLibName name 'SetProcessShutdownParameters';
function SetProcessWorkingSetSize(hProcess: THandle; dwMinimumWorkingSetSize, dwMaximumWorkingSetSize: DWORD): BOOL; stdcall; external cLibName name 'SetProcessWorkingSetSize';
function SetStdHandle(nStdHandle: DWORD; hHandle: THandle): BOOL; stdcall; external cLibName name 'SetStdHandle';
function SetSystemPowerState(fSuspend, fForce: BOOL): BOOL; stdcall; external cLibName name 'SetSystemPowerState';
function SetSystemTime(const lpSystemTime: TSystemTime): BOOL; stdcall; external cLibName name 'SetSystemTime';
function SetSystemTimeAdjustment(dwTimeAdjustment: DWORD; bTimeAdjustmentDisabled: BOOL): BOOL; stdcall; external cLibName name 'SetSystemTimeAdjustment';
function SetTapeParameters(hDevice: THandle; dwOperation: DWORD; lpTapeInformation: Pointer): DWORD; stdcall; external cLibName name 'SetTapeParameters';
function SetTapePosition(hDevice: THandle; dwPositionMethod, dwPartition: DWORD; dwOffsetLow, dwOffsetHigh: DWORD; bImmediate: BOOL): DWORD; stdcall; external cLibName name 'SetTapePosition';
function SetThreadAffinityMask(hThread: THandle; dwThreadAffinityMask: nativeuint): DWORD; stdcall; external cLibName name 'SetThreadAffinityMask';
function SetThreadContext(hThread: THandle; const lpContext: TContext): BOOL; stdcall; external cLibName name 'SetThreadContext';
function SetThreadIdealProcessor(hThread: THandle; dwIdealProcessor: DWORD): BOOL; stdcall; external cLibName name 'SetThreadIdealProcessor';
function SetThreadLocale(Locale: LCID): BOOL; stdcall; external cLibName name 'SetThreadLocale';
function SetThreadPriority(hThread: THandle; nPriority: Integer): BOOL; stdcall; external cLibName name 'SetThreadPriority';
function SetThreadPriorityBoost(hThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall; external cLibName name 'SetThreadPriorityBoost';
function SetTimeZoneInformation(const lpTimeZoneInformation: TTimeZoneInformation): BOOL; stdcall; external cLibName name 'SetTimeZoneInformation';
function SetUnhandledExceptionFilter(lpTopLevelExceptionFilter: TUnhandledExceptionFilter): TUnhandledExceptionFilter; stdcall; external cLibName name 'SetUnhandledExceptionFilter';
function SetVolumeLabel(lpRootPathName: PAnsiChar; lpVolumeName: PAnsiChar): BOOL; stdcall; external cLibName name 'SetVolumeLabelA';
function SetVolumeLabelW(lpRootPathName: PWideChar; lpVolumeName: PAnsiChar): BOOL; stdcall; external cLibName name 'SetVolumeLabelW';
function SetWaitableTimer(hTimer: THandle; var lpDueTime: TLargeInteger; lPeriod: Longint; pfnCompletionRoutine: TimerAPCProc; lpArgToCompletionRoutine: Pointer; fResume: BOOL): BOOL; stdcall; external cLibName name 'SetWaitableTimer';
function SetupComm(hFile: THandle; dwInQueue, dwOutQueue: DWORD): BOOL; stdcall; external cLibName name 'SetupComm';
function SignalObjectAndWait(hObjectToSignal: THandle; hObjectToWaitOn: THandle; dwMilliseconds: DWORD; bAlertable: BOOL): BOOL; stdcall; external cLibName name 'SignalObjectAndWait';
function SizeofResource(hModule: THINST; hResInfo: THRSRC): DWORD; stdcall; external cLibName name 'SizeofResource';
procedure Sleep(dwMilliseconds: DWORD); stdcall; external cLibName name 'Sleep';
function SleepEx(dwMilliseconds: DWORD; bAlertable: BOOL): DWORD; stdcall; external cLibName name 'SleepEx';
function SuspendThread(hThread: THandle): DWORD; stdcall; external cLibName name 'SuspendThread';
function SwitchToFiber(lpFiber: Pointer): BOOL; stdcall; external cLibName name 'SwitchToFiber';
function SwitchToThread: BOOL; stdcall; external cLibName name 'SwitchToThread';
function SystemTimeToFileTime(const lpSystemTime: TSystemTime; var lpFileTime: TFileTime): BOOL; stdcall; external cLibName name 'SystemTimeToFileTime';
function SystemTimeToTzSpecificLocalTime(lpTimeZoneInformation: PTimeZoneInformation; var lpUniversalTime, lpLocalTime: TSystemTime): BOOL; stdcall; external cLibName name 'SystemTimeToTzSpecificLocalTime';
function TerminateProcess(hProcess: THandle; uExitCode: UINT): BOOL; stdcall; external cLibName name 'TerminateProcess';
function TerminateThread(hThread: THandle; dwExitCode: DWORD): BOOL; stdcall; external cLibName name 'TerminateThread';
function Thread32First(hSnapshot: THandle; var lpte: TThreadEntry32): BOOL; stdcall; external cLibName name 'Thread32First';
function Thread32Next(hSnapshot: THandle; var lpte: TThreadENtry32): BOOL; stdcall; external cLibName name 'Thread32Next';
function TlsAlloc: DWORD; stdcall; external cLibName name 'TlsAlloc';
function TlsFree(dwTlsIndex: DWORD): BOOL; stdcall; external cLibName name 'TlsFree';
function TlsGetValue(dwTlsIndex: DWORD): Pointer; stdcall; external cLibName name 'TlsGetValue';
function TlsSetValue(dwTlsIndex: DWORD; lpTlsValue: Pointer): BOOL; stdcall; external cLibName name 'TlsSetValue';
function Toolhelp32ReadProcessMemory(th32ProcessID: DWORD; lpBaseAddress: Pointer; var lpBuffer; cbRead: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall; external cLibName name 'Toolhelp32ReadProcessMemory';
function TransactNamedPipe(hNamedPipe: THandle; lpInBuffer: Pointer; nInBufferSize: DWORD; lpOutBuffer: Pointer; nOutBufferSize: DWORD; var lpBytesRead: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'TransactNamedPipe';
function TransmitCommChar(hFile: THandle; cChar: char): BOOL; stdcall; external cLibName name 'TransmitCommChar';
function TryEnterCriticalSection(var lpCriticalSection: TRTLCriticalSection): BOOL; stdcall; external cLibName name 'TryEnterCriticalSection';
function UnhandledExceptionFilter(const ExceptionInfo: TExceptionPointers): Longint; stdcall; external cLibName name 'UnhandledExceptionFilter';
function UnlockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToUnlockLow, nNumberOfBytesToUnlockHigh: DWORD): BOOL; stdcall; external cLibName name 'UnlockFile';
function UnlockFileEx(hFile: THandle; dwReserved, nNumberOfBytesToUnlockLow: DWORD; nNumberOfBytesToUnlockHigh: DWORD; const lpOverlapped: TOverlapped): BOOL; stdcall; external cLibName name 'UnlockFileEx';
function UnmapViewOfFile(lpBaseAddress: Pointer): BOOL; stdcall; external cLibName name 'UnmapViewOfFile';
function UpdateResource(hUpdate: THandle; lpType, lpName: PAnsiChar; wLanguage: Word; lpData: Pointer; cbData: DWORD): BOOL; stdcall; external cLibName name 'UpdateResourceA';
function UpdateResourceW(hUpdate: THandle; lpType, lpName: PWideChar; wLanguage: Word; lpData: Pointer; cbData: DWORD): BOOL; stdcall; external cLibName name 'UpdateResourceW';
function VerLanguageName(wLang: DWORD; szLang: PAnsiChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'VerLanguageNameA';
function VerLanguageNameW(wLang: DWORD; szLang: PWideChar; nSize: DWORD): DWORD; stdcall; external cLibName name 'VerLanguageNameW';
function VirtualAlloc(lpvAddress: Pointer; dwSize, flAllocationType, flProtect: DWORD): Pointer; stdcall; external cLibName name 'VirtualAlloc';
function VirtualAllocEx(hProcess: THandle; lpAddress: Pointer; dwSize, flAllocationType: DWORD; flProtect: DWORD): Pointer; stdcall; external cLibName name 'VirtualAllocEx';
function VirtualFree(lpAddress: Pointer; dwSize, dwFreeType: DWORD): BOOL; stdcall; external cLibName name 'VirtualFree';
function VirtualFreeEx(hProcess: THandle; lpAddress: Pointer; dwSize, dwFreeType: DWORD): Pointer; stdcall; external cLibName name 'VirtualFreeEx';
function VirtualLock(lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external cLibName name 'VirtualLock';
function VirtualProtect(lpAddress: Pointer; dwSize, flNewProtect: DWORD; lpflOldProtect: Pointer): BOOL; stdcall; external cLibName name 'VirtualProtect';
function VirtualProtectEx(hProcess: THandle; lpAddress: Pointer; dwSize, flNewProtect: DWORD; lpflOldProtect: Pointer): BOOL; stdcall; external cLibName name 'VirtualProtectEx';
function VirtualQuery(lpAddress: Pointer; var lpBuffer: TMemoryBasicInformation; dwLength: DWORD): DWORD; stdcall; external cLibName name 'VirtualQuery';
function VirtualQueryEx(hProcess: THandle; lpAddress: Pointer; var lpBuffer: TMemoryBasicInformation; dwLength: DWORD): DWORD; stdcall; external cLibName name 'VirtualQueryEx';
function VirtualUnlock(lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external cLibName name 'VirtualUnlock';
function WaitCommEvent(hFile: THandle; var lpEvtMask: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'WaitCommEvent';
function WaitForDebugEvent(var lpDebugEvent: TDebugEvent; dwMilliseconds: DWORD): BOOL; stdcall; external cLibName name 'WaitForDebugEvent';
function WaitForMultipleObjects(nCount: DWORD; lpHandles: PHandleArray; bWaitAll: BOOL; dwMilliseconds: DWORD): DWORD; stdcall; external cLibName name 'WaitForMultipleObjects';
function WaitForMultipleObjectsEx(nCount: DWORD; lpHandles: PHandleArray; bWaitAll: BOOL; dwMilliseconds: DWORD; bAlertable: BOOL): DWORD; stdcall; external cLibName name 'WaitForMultipleObjectsEx';
function WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD; stdcall; external cLibName name 'WaitForSingleObject';
function WaitForSingleObjectEx(hHandle: THandle; dwMilliseconds: DWORD; bAlertable: BOOL): DWORD; stdcall; external cLibName name 'WaitForSingleObjectEx';
function WaitNamedPipe(lpNamedPipeName: PAnsiChar; nTimeOut: DWORD): BOOL; stdcall; external cLibName name 'WaitNamedPipeA';
function WaitNamedPipeW(lpNamedPipeName: PWideChar; nTimeOut: DWORD): BOOL; stdcall; external cLibName name 'WaitNamedPipeW';
function WideCharToMultiByte(CodePage: UINT; dwFlags: DWORD; lpWideCharStr: LPWSTR; cchWideChar: Integer; lpMultiByteStr: LPSTR; cchMultiByte: Integer; lpDefaultChar: LPCSTR; lpUsedDefaultChar: PBOOL): Integer; stdcall; external cLibName name 'WideCharToMultiByte';
function WinExec(lpCmdLine: LPCSTR; uCmdShow: UINT): UINT; stdcall; external cLibName name 'WinExec';
function WriteConsole(hConsoleOutput: THandle; const lpBuffer: Pointer; nNumberOfCharsToWrite: DWORD; var lpNumberOfCharsWritten: DWORD; lpReserved: Pointer): BOOL; stdcall; external cLibName name 'WriteConsoleA';
function WriteConsoleInput(hConsoleInput: THandle; const lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteConsoleInputA';
function WriteConsoleInputW(hConsoleInput: THandle; const lpBuffer: TInputRecord; nLength: DWORD; var lpNumberOfEventsWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteConsoleInputW';
function WriteConsoleOutput(hConsoleOutput: THandle; lpBuffer: Pointer; dwBufferSize, dwBufferCoord: TCoord; var lpWriteRegion: TSmallRect): BOOL; stdcall; external cLibName name 'WriteConsoleOutputA';
function WriteConsoleOutputAttribute(hConsoleOutput: THandle; lpAttribute: Pointer; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfAttrsWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteConsoleOutputAttribute';
function WriteConsoleOutputCharacter(hConsoleOutput: THandle; lpCharacter: PAnsiChar; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfCharsWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteConsoleOutputCharacterA';
function WriteConsoleOutputCharacterW(hConsoleOutput: THandle; lpCharacter: PWideChar; nLength: DWORD; dwWriteCoord: TCoord; var lpNumberOfCharsWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteConsoleOutputCharacterW';
function WriteConsoleOutputW(hConsoleOutput: THandle; lpBuffer: Pointer; dwBufferSize, dwBufferCoord: TCoord; var lpWriteRegion: TSmallRect): BOOL; stdcall; external cLibName name 'WriteConsoleOutputW';
function WriteConsoleW(hConsoleOutput: THandle; const lpBuffer: Pointer; nNumberOfCharsToWrite: DWORD; var lpNumberOfCharsWritten: DWORD; lpReserved: Pointer): BOOL; stdcall; external cLibName name 'WriteConsoleW';
function WriteFile(hFile: THandle; const Buffer; nNumberOfBytesToWrite: DWORD; var lpNumberOfBytesWritten: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external cLibName name 'WriteFile';
function WriteFileEx(hFile: THandle; lpBuffer: Pointer; nNumberOfBytesToWrite: DWORD; const lpOverlapped: TOverlapped; lpCompletionRoutine: pointer): BOOL; stdcall; external cLibName name 'WriteFileEx';
function WritePrivateProfileSection(lpAppName, lpString, lpFileName: PAnsiChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileSectionA';
function WritePrivateProfileSectionW(lpAppName, lpString, lpFileName: PWideChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileSectionW';
function WritePrivateProfileString(lpAppName, lpKeyName, lpString, lpFileName: PAnsiChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileStringA';
function WritePrivateProfileStringW(lpAppName, lpKeyName, lpString, lpFileName: PWideChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileStringW';
function WritePrivateProfileStruct(lpszSection, lpszKey: PAnsiChar; lpStruct: Pointer; uSizeStruct: UINT; szFile: PAnsiChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileStructA';
function WritePrivateProfileStructW(lpszSection, lpszKey: PWideChar; lpStruct: Pointer; uSizeStruct: UINT; szFile: PWideChar): BOOL; stdcall; external cLibName name 'WritePrivateProfileStructW';
function WriteProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer; nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall; external cLibName name 'WriteProcessMemory';
function WriteProfileSection(lpAppName, lpString: PAnsiChar): BOOL; stdcall; external cLibName name 'WriteProfileSectionA';
function WriteProfileSectionW(lpAppName, lpString: PWideChar): BOOL; stdcall; external cLibName name 'WriteProfileSectionW';
function WriteProfileString(lpAppName, lpKeyName, lpString: PAnsiChar): BOOL; stdcall; external cLibName name 'WriteProfileStringA';
function WriteProfileStringW(lpAppName, lpKeyName, lpString: PWideChar): BOOL; stdcall; external cLibName name 'WriteProfileStringW';
function WriteTapemark(hDevice: THandle; dwTapemarkType, dwTapemarkCount: DWORD; bImmediate: BOOL): DWORD; stdcall; external cLibName name 'WriteTapemark';
function _hread(hFile: THFILE; lpBuffer: Pointer; lBytes: Longint): Longint; stdcall; external cLibName name '_hread';
function _hwrite(hFile: THFILE; lpBuffer: LPCSTR; lBytes: Longint): Longint; stdcall; external cLibName name '_hwrite';
function _lclose(hFile: THFILE): THFILE; stdcall; external cLibName name '_lclose';
function _lcreat(const lpPathName: LPCSTR; iAttribute: Integer): THFILE; stdcall; external cLibName name '_lcreat';
function _llseek(hFile: THFILE; lOffset: Longint; iOrigin: Integer): Longint; stdcall; external cLibName name '_llseek';
function _lopen(const lpPathName: LPCSTR; iReadWrite: Integer): THFILE; stdcall; external cLibName name '_lopen';
function _lread(hFile: THFILE; lpBuffer: Pointer; uBytes: UINT): UINT; stdcall; external cLibName name '_lread';
function _lwrite(hFile: THFILE; const lpBuffer: LPCSTR; uBytes: UINT): UINT; stdcall; external cLibName name '_lwrite';
function lstrcat(lpString1, lpString2: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'lstrcatA';
function lstrcatW(lpString1, lpString2: PWideChar): PWideChar; stdcall; external cLibName name 'lstrcatW';
function lstrcmp(lpString1, lpString2: PAnsiChar): Integer; stdcall; external cLibName name 'lstrcmpA';
function lstrcmpW(lpString1, lpString2: PWideChar): Integer; stdcall; external cLibName name 'lstrcmpW';
function lstrcmpi(lpString1, lpString2: PAnsiChar): Integer; stdcall; external cLibName name 'lstrcmpiA';
function lstrcmpiW(lpString1, lpString2: PWideChar): Integer; stdcall; external cLibName name 'lstrcmpiW';
function lstrcpy(lpString1, lpString2: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'lstrcpyA';
function lstrcpyW(lpString1, lpString2: PWideChar): PWideChar; stdcall; external cLibName name 'lstrcpyW';
function lstrcpyn(lpString1, lpString2: PAnsiChar; iMaxLength: Integer): PAnsiChar; stdcall; external cLibName name 'lstrcpynA';
function lstrcpynW(lpString1, lpString2: PWideChar; iMaxLength: Integer): PWideChar; stdcall; external cLibName name 'lstrcpynW';
function lstrlen(lpString: PAnsiChar): Integer; stdcall; external cLibName name 'lstrlenA';
function lstrlenW(lpString: PWideChar): Integer; stdcall; external cLibName name 'lstrlenW';




//* -------------------------- DISK VOLUMES ---------------------------------*//

/// <summary>
///   FROM MSDN: Retrieves the name of a volume on a computer. FindFirstVolume is used to
///   begin scanning the volumes of a computer.
/// </summary>
/// <param name="lpszVolumeName">
///   FROM MSDN: A pointer to a buffer that receives a null-terminated string that
///   specifies a volume GUID path for the first volume that is found. <br />
/// </param>
/// <param name="cchBufferLength">
///   FROM MSDN: The length of the buffer to receive the volume GUID path, in TCHARs.
/// </param>
/// <returns>
///   FROM MSDN: The length of the buffer to receive the volume GUID path, in TCHARs.
/// </returns>
/// <remarks>
///   FROM MSDN: The FindFirstVolume function opens a volume search handle and returns
///   information about the first volume found on a computer. After the search
///   handle is established, you can use the FindNextVolume function to search
///   for other volumes. When the search handle is no longer needed, close it
///   by using the FindVolumeClose function. <br />You should not assume any
///   correlation between the order of the volumes that are returned by these
///   functions and the order of the volumes that are on the computer. In
///   particular, do not assume any correlation between volume order and drive
///   letters as assigned by the BIOS (if any) or the Disk Administrator.
/// </remarks>
function FindFirstVolume( lpszVolumeName: pointer; cchBufferLength: uint32 ): THandle; stdcall; external cLibName name 'FindFirstVolumeW';

/// <summary>
///   FROM MSDN: Continues a volume search started by a call to the FindFirstVolume
///   function. FindNextVolume finds one volume per call.
/// </summary>
/// <param name="hFindVolume">
///   FROM MSDN: The volume search handle returned by a previous call to the
///   FindFirstVolume function.
/// </param>
/// <param name="lptstrVolumeName">
///   FROM MSDN: A pointer to a string that receives the volume GUID path that is found.
/// </param>
/// <param name="cchBufferLength">
///   FROM MSDN: The length of the buffer that receives the volume GUID path, in TCHARs.
/// </param>
/// <returns>
///   FROM MSDN: If the function succeeds, the return value is nonzero. <br />If the
///   function fails, the return value is zero. To get extended error
///   information, call GetLastError. If no matching files can be found, the
///   GetLastError function returns the ERROR_NO_MORE_FILES error code. In that
///   case, close the search with the FindVolumeClose function.
/// </returns>
/// <remarks>
///   FROM MSDN: After the search handle is established by calling FindFirstVolume, you
///   can use the FindNextVolume function to search for other volumes. <br />
///   You should not assume any correlation between the order of the volumes
///   that are returned by these functions and the order of the volumes that
///   are on the computer. In particular, do not assume any correlation between
///   volume order and drive letters as assigned by the BIOS (if any) or the
///   Disk Administrator.
/// </remarks>
function FindNextVolume( hFindVolume: THandle; lptstrVolumeName: pointer; cchBufferLength: uint32 ): boolean; stdcall; external cLibName name 'FindNextVolumeW';

/// <summary>
///   FROM MSDN: Closes the specified volume search handle. The FindFirstVolume and
///   FindNextVolume functions use this search handle to locate volumes.
/// </summary>
/// <param name="hFindVolume">
///   FROM MSDN: The volume search handle to be closed. This handle must have been
///   previously opened by the FindFirstVolume function.
/// </param>
/// <returns>
///   FROM MSDN: If the function succeeds, the return value is nonzero. <br />If the
///   function fails, the return value is zero. To get extended error
///   information, call GetLastError.
/// </returns>
/// <remarks>
///   FROM MSDN: After the FindVolumeClose function is called, the handle hFindVolume
///   cannot be used in subsequent calls to either FindNextVolume or
///   FindVolumeClose.
/// </remarks>
function FindVolumeClose( hFindVolume: THandle ): boolean; stdcall; external cLibName name 'FindVolumeClose';

/// <summary>
///   FROM MSDN: Retrieves a list of drive letters and mounted folder paths for the
///   specified volume.
/// </summary>
/// <param name="lpszVolumeName">
///   FROM MSDN: A volume GUID path for the volume. A volume GUID path is of the form
///   "\\?\Volume{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}\".
/// </param>
/// <param name="lpszVolumePathNames">
///   FROM MSDN: A pointer to a buffer that receives the list of drive letters and mounted
///   folder paths. The list is an array of null-terminated strings terminated
///   by an additional NULL character. If the buffer is not large enough to
///   hold the complete list, the buffer holds as much of the list as possible.
/// </param>
/// <param name="cchBufferLength">
///   FROM MSDN: The length of the lpszVolumePathNames buffer, in TCHARs, including all
///   NULL characters.
/// </param>
/// <param name="lpcchReturnLength">
///   FROM MSDN: If the call is successful, this parameter is the number of TCHARs copied
///   to the lpszVolumePathNames buffer. Otherwise, this parameter is the size
///   of the buffer required to hold the complete list, in TCHARs.
/// </param>
/// <returns>
///   FROM MSDN: If the function succeeds, the return value is nonzero. (bool true) <br />
///   If the function fails, the return value is zero. To get extended error
///   information, call GetLastError. If the buffer is not large enough to hold
///   the complete list, the error code is ERROR_MORE_DATA and the
///   lpcchReturnLength parameter receives the required buffer size.
/// </returns>
function GetVolumePathNamesForVolumeName( lpszVolumeName: pointer; lpszVolumePathNames: pointer; cchBufferLength: uint32; var lpcchReturnLength: uint32 ): boolean; stdcall; external cLibName name 'GetVolumePathNamesForVolumeNameW';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-acquiresrwlockexclusive
///  </summary>
procedure AcquireSRWLockExclusive( var SRWLock: TSRWLock ); stdcall; external cLibName name 'AcquireSRWLockExclusive';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-initializesrwlock
///  </summary>
procedure InitializeSRWLock( var SRWLock: TSRWLock ); stdcall; external cLibName name 'InitializeSRWLock';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-initializeconditionvariable
///  </summary>
procedure InitializeConditionVariable( var ConditionVariable: TCONDITION_VARIABLE ); stdcall; external cLibName name 'InitializeConditionVariable';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-releasesrwlockexclusive
///  </summary>
procedure ReleaseSRWLockExclusive( var SRWLock: TSRWLock ); stdcall; external cLibName name 'ReleaseSRWLockExclusive';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-sleepconditionvariablesrw
///  </summary>
function SleepConditionVariableSRW( var ConditionVariable: TCONDITION_VARIABLE; var SRWLock: TSRWLock; const dwMilliseconds: uint32; const flags: uint64 ): boolean; stdcall; external cLibName name 'SleepConditionVariableSRW';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-wakeconditionvariable
///  </summary>
procedure WakeConditionVariable( var ConditionVariable: TCONDITION_VARIABLE ); stdcall; external cLibName name 'WakeConditionVariable';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getthreadid
///  </summary>
function GetThreadId( const Thread: THANDLE ): uint32; stdcall; external cLibName name 'GetThreadId';

{$endif}
implementation


end.


