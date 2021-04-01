@echo off
rem Add this file to c:\
rem Add a registy autorun entry:
rem     reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "%HOMEDRIVE%%HOMEPATH%\.winautorun.cmd" /f
rem Verify setting with:
rem     reg query "HKCU\Software\Microsoft\Command Processor" /v Autorun

doskey gls=git log --stat --decorate --graph --abbrev-commit
doskey glsw=git log --stat --decorate --graph --abbrev-commit --stat-width=120
doskey gss=git status -s
doskey glo=git log --graph --format="%%C(auto) %%h %%aE %%d %%s"
doskey glist=git show --pretty="" --name-only

doskey exp=explorer %HOMEPATH%\projects
doskey ex.=explorer .
doskey history=doskey /history

doskey scp=cd %HOMEPATH%\projects

rem ==== work related
doskey scs=cd %DOSKEY_SC_SCRIPTS_DIR%

prompt $P$_$G$S
