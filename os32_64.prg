LOCAL lnHandle, lnProceso64
 
  DO DECLARAR_API
 
  lnHandle = GetCurrentProcess()
 
  lnProceso64 = 0
 
  =IsWow64Process(lnHandle, @lnProceso64)
 
  =CloseHandle(lnHandle)
 
  ? IIF(lnProceso64 = 0, "32 bits", "64 bits")
 
RETURN
*
*
PROCEDURE DECLARAR_API
 
  DECLARE INTEGER GetCurrentProcess IN KERNEL32
 
  DECLARE INTEGER CloseHandle IN KERNEL32 ;
    INTEGER hObject
 
  DECLARE INTEGER IsWow64Process IN KERNEL32 ;
    INTEGER hProcess, ;
    INTEGER @Wow64Process
 
RETURN
*
*