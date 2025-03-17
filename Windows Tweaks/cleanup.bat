@echo off
title System Cleanup Script
color 0A
cls

:: Function to display progress
:display_progress
setlocal enabledelayedexpansion
set "progress_chars=\|/-"
for /l %%i in (0,1,100) do (
    set /a "progress_idx=%%i %% 4"
    set "progress_char=!progress_chars:~%progress_idx%,1!"
    echo Processing... %%i%%
    ping -n 2 127.0.0.1 > nul
    cls
)
endlocal
goto :eof

:: Function to delete files and folders
:delete_files
echo %1
del /s /f /q %1 >nul 2>&1
rd /s /q %1 >nul 2>&1
goto :eof

echo Cleaning up system...

:: Delete temporary files
call :display_progress
call :delete_files %temp%\*
call :delete_files C:\Windows\Temp\*
call :delete_files %tmp%
call :delete_files %windir%\Prefetch\*
call :delete_files %LOCALAPPDATA%\Microsoft\Windows\Caches\*
call :delete_files %windir%\SoftwareDistribution\Download\*
call :delete_files %programdata%\Microsoft\Windows\WER\Temp\*
call :delete_files %HomePath%\AppData\LocalLow\Temp\*
call :delete_files %windir%\Logs\CBS\CbsPersist*.log
call :delete_files %windir%\Logs\MoSetup\*.log
call :delete_files %windir%\Panther\*.log
call :delete_files %localappdata%\Microsoft\Windows\WebCache\*.log
call :delete_files %localappdata%\Microsoft\Windows\INetCache\*.log
call :delete_files %ProgramData%\USOPrivate
call :delete_files %ProgramData%\USOShared
call :delete_files %ProgramData%\IDM
call :delete_files %HomePath%\AppData\Local\Comms
call :delete_files %HomePath%\AppData\Local\D3DSCache
call :delete_files %HomePath%\AppData\Roaming\DMCache
call :delete_files %HomePath%\AppData\Local\PeerDistRepub
call :delete_files %HomePath%\AppData\Local\StartIsBack

:: Clear Windows Defender logs
echo Clearing Windows Defender logs...
call :display_progress
del "%ProgramData%\Microsoft\Windows Defender\Network Inspection System\Support\*.log" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\CacheManager" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\ReportLatency\Latency" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\MetaStore" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Support" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Quick" /F /Q /S >nul 2>&1
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Resource" /F /Q /S >nul 2>&1

:: Reset network configurations
echo Resetting network configurations...
call :display_progress
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1

:: Power settings
echo Setting power configuration...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 95533644-e700-4a79-a56c-a89e8cb109d9 >nul 2>&1
powercfg -setactive 95533644-e700-4a79-a56c-a89e8cb109d9 >nul 2>&1

:: Clear the Recycle Bin
echo Clearing Recycle Bin...
call :display_progress
rd /s /q %systemdrive%\$Recycle.Bin >nul 2>&1

:: Run Disk Cleanup
echo Running Disk Cleanup...
cleanmgr /sagerun:1 >nul 2>&1

:: End of script
echo Cleanup completed!
pause
exit
