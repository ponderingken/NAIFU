@echo off
setlocal

set RUNTIME_URI=https://aka.ms/vs/17/release/vc_redist.x64.exe
set ARIA2_URI=https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip
set PYTHON_URI=https://www.python.org/ftp/python/3.10.8/python-3.10.8-embed-amd64.zip
set PYTHIN_PIP_URI=https://bootstrap.pypa.io/get-pip.py
set NAIFU_MAGNET="magnet:?xt=urn:btih:4a4b483d4a5840b6e1fee6b0ca1582c979434e4d&dn=naifu&tr=udp%%3a%%2f%%2ftracker.opentrackr.org%%3a1337%%2fannounce"

set MVR_HKLM86=HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
set MVR_HKLM64=HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set MVR_HKCU=HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

echo This batch file is for NAIFU setup. Do not move it to another location and run it. The file may be lost.
echo Press any key to continue.
pause > nul

if exist "%~dp0tmp" rd /s /q "%~dp0tmp"
mkdir "%~dp0tmp"

set /a count = 0
for /f "usebackq delims=" %%A in (`powershell -Command "Get-ChildItem -Path( '%MVR_HKLM86%', '%MVR_HKLM64%', '%MVR_HKCU%') | %% { Get-ItemProperty $_.PsPath | Select-Object DisplayName} | findstr /r /c:'Microsoft Visual C++.*X64.*Runtime.*' /c:'Microsoft Visual C++.*Redistributable (x64).*'"`) do (
    echo %%A | findstr "Debug Minimum Additional Redistributable" > nul
    if not errorlevel 1 set /a count += 1
)
if %count% equ 0 (
    echo [33mCould not find Microsoft Visual C++ X64 Runtime.
    echo Let the installer run and complete.
    echo If a reboot is required, reboot and run this batch file again.[0m
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%RUNTIME_URI%','%~dp0tmp\vc_redist.x64.exe')"
    "%~dp0tmp\vc_redist.x64.exe"
    del "%~dp0tmp\vc_redist.x64.exe"
    echo Run it again.
    goto :EXIT
) else (
    echo Microsoft Visual C++ Runtime confirmed.
)

echo Preparing the download tool
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%ARIA2_URI%','%~dp0tmp\aria2.zip')"
powershell Expand-Archive -Path "%~dp0tmp\aria2.zip" -DestinationPath "%~dp0tmp\aria2" > nul
del "%~dp0tmp\aria2.zip"
for /f "usebackq delims=" %%A in (`where /r "%~dp0tmp\aria2" *.exe`) do set ARIAPATH=%%A
move %ARIAPATH% "%~dp0tmp\" > nul
rd /s /q "%~dp0tmp\aria2"

echo Downloading the Naifu
"%~dp0tmp\aria2c.exe" --seed-time=0 --dir="%~dp0tmp" %NAIFU_MAGNET%
del "%~dp0tmp\aria2c.exe"

echo Downloading the Python
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PYTHON_URI%','%~dp0tmp\python.zip')"
powershell Expand-Archive -Path "%~dp0tmp\python.zip" -DestinationPath "%~dp0python" > nul
del "%~dp0tmp\python.zip"

echo Preparing for pip
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PYTHIN_PIP_URI%','%~dp0tmp\get-pip.py')"
"%~dp0python\python.exe" "%~dp0tmp\get-pip.py" --no-warn-script-location
del "%~dp0tmp\get-pip.py"
powershell -Command "[System.IO.File]::WriteAllLines(('%~dp0tmp\replaced'), @((gc '%~dp0python\python310._pth').Replace('#import site', 'import site')), (New-Object 'System.Text.UTF8Encoding' -ArgumentList @($false)))" > nul
copy /y "%~dp0tmp\replaced" "%~dp0python\python310._pth" > nul
del /q "%~dp0tmp\replaced"

echo Installing modules required to run Naifu
"%~dp0python\Scripts\pip.exe" install -r requirements.txt --no-warn-script-location

echo Installing the naifu
move "%~dp0tmp\naifu\models" "%~dp0models" > nul
rd /s /q "%~dp0tmp\naifu"

powershell -Command "[System.IO.File]::WriteAllLines(('%~dp0tmp\replaced'), @((gc '%~dp0run.bat').Replace('set PYTHON=python', 'set PYTHON=python\python.exe')), (New-Object 'System.Text.UTF8Encoding' -ArgumentList @($false)))" > nul
copy /y "%~dp0tmp\replaced" "%~dp0run.bat" > nul
del /q "%~dp0tmp\replaced"

rd /s /q "%~dp0tmp"

echo [32m
echo    .__   __.      ___       __   _______  __    __
echo    ^|  \ ^|  ^|     /   \     ^|  ^| ^|   ____^|^|  ^|  ^|  ^|
echo    ^|   \^|  ^|    /  ^^  \    ^|  ^| ^|  ^|__   ^|  ^|  ^|  ^|
echo    ^|  . `  ^|   /  /_\  \   ^|  ^| ^|   __^|  ^|  ^|  ^|  ^|
echo    ^|  ^|\   ^|  /  _____  \  ^|  ^| ^|  ^|     ^|  `--'  ^|
echo    ^|__^| \__^| /__/     \__\ ^|__^| ^|__^|      \______/
echo.
echo All setups have been completed
echo.
echo Please note that this content is based on leaked electronic data and we are not responsible for any disadvantages that may occur as a result of the actual construction and execution of this content.
echo.
echo Therefore, all further execution is at your own risk.
echo.
echo It can be executed from the ^"run.bat^" file of NAIFU.
echo.
echo ^(Done^)[0m
echo.

:EXIT
pause
endlocal
exit