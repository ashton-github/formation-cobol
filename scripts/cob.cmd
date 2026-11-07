@echo off
rem cob.cmd : compile (GnuCOBOL) puis execute un programme COBOL (Windows natif).
rem Usage : cob [-c] [-f] [-d] programme.cob [sous-programme.cob ...]
setlocal
set FORMAT=-free
set RUN=1
set DEBUG=
:opts
if "%~1"=="-c" (set RUN=0) & shift & goto opts
if "%~1"=="-f" (set FORMAT=-fixed) & shift & goto opts
if "%~1"=="-d" (set DEBUG=-debug -g) & shift & goto opts
if "%~1"=="" goto usage
set MAIN=%~1
set FILES=
:loop
if "%~1"=="" goto build
set FILES=%FILES% "%~1"
shift
goto loop
:build
where cobc >nul 2>nul
if errorlevel 1 (echo GnuCOBOL ^(cobc^) introuvable. Voir README.md & exit /b 1)
for %%F in ("%MAIN%") do set NAME=%%~nF
for %%F in ("%MAIN%") do set DIR=%%~dpF
if not exist "%TEMP%\cob-build" mkdir "%TEMP%\cob-build"
echo ^>^> Compilation : cobc -x %FORMAT% %DEBUG% %FILES%
cobc -x %FORMAT% %DEBUG% -W -I "%DIR%." -I "%DIR%..\copy" -o "%TEMP%\cob-build\%NAME%.exe" %FILES%
if errorlevel 1 (echo ^>^> ECHEC de la compilation & exit /b 1)
echo ^>^> OK - execution :
echo -----------------------------------------------
if "%RUN%"=="1" "%TEMP%\cob-build\%NAME%.exe"
exit /b %errorlevel%
:usage
echo Usage : cob [-c] [-f] [-d] programme.cob [sous-programme.cob ...]
exit /b 1
