@echo off
if "%WINAUTORUN_WAS_RUN%"=="1" (goto :eof)
set WINAUTORUN_WAS_RUN=1

rem Install clink autorun (injects clink into every cmd.exe session):
rem     clink autorun install -- --profile "%USERPROFILE%\.clink"
rem Verify with:
rem     clink autorun show
rem     clink info
rem Remove/uninstall:
rem     clink autorun uninstall

rem Install this file as cmd.exe autorun:
rem     reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "%HOMEDRIVE%%HOMEPATH%\.winautorun.cmd" /f
rem Verify with:
rem     reg query "HKCU\Software\Microsoft\Command Processor" /v Autorun
rem Remove/uninstall:
rem     reg delete "HKCU\Software\Microsoft\Command Processor" /v Autorun /f

set CLINK_PATH=%USERPROFILE%\.clink.local
