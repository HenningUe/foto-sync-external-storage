@echo off
set MYDIR=%~dp0

echo ++ Set variables needed ++
set VIRT_ENV_NAME=fotosync
if exist "%MYDIR%fotosync_pyexe_dir.cmd" call "%MYDIR%fotosync_pyexe_dir.cmd"
if "%PY_EXE_DIR%"=="" (
    FOR /f %%p in ('where python') do SET PY_EXE_DIR=%%p
)
echo PY_EXE_DIR is "%PY_EXE_DIR%"
echo ---
echo ---

echo ++ Check python ++
if not exist %PY_EXE_DIR% goto :ERR_MISSING_PYTHON
echo "%PY_EXE_DIR%\Scripts\pip" install virtualenv
"%PY_EXE_DIR%\Scripts\pip" install virtualenv
::where virtualenv >nul 2>nul
::if %ERRORLEVEL% NEQ 0 goto :ERR_MISSING_VIRTENV
echo ---
echo ---

echo ++ Prepare virtual environment ++
set VIRT_ENV_DIR=%TEMP%\%VIRT_ENV_NAME%
if exist "%VIRT_ENV_DIR%" rmdir "%VIRT_ENV_DIR%" /s /q 
::"%PY_EXE_DIR%\Scripts\virtualenv" --python "%PY_EXE_DIR%\python.exe" %VIRT_NAME%
echo "%PY_EXE_DIR%\Scripts\virtualenv" --python "%PY_EXE_DIR%\python.exe" "%VIRT_ENV_DIR%"
"%PY_EXE_DIR%\Scripts\virtualenv" --python "%PY_EXE_DIR%\python.exe" "%VIRT_ENV_DIR%"
echo call "%VIRT_ENV_DIR%\scripts\activate.bat"
call "%VIRT_ENV_DIR%\scripts\activate.bat"
echo ---
echo ---

echo ++ Install needed packages in virtual env ++
echo "%VIRT_ENV_DIR%\scripts\pip" install -r "%MYDIR%requirements.txt"
"%VIRT_ENV_DIR%\scripts\pip" install -r "%MYDIR%requirements.txt"
echo ---
echo ---

echo ++ Call pyinstaller ++
set PYINST="%VIRT_ENV_DIR%\scripts\pyinstaller"
if exist "%MYDIR%build" rmdir "%MYDIR%build" /s /q 
if exist "%MYDIR%dist" rmdir "%MYDIR%dist" /s /q 
echo %PYINST% --onefile --console --icon "%MYDIR%resources\fotosync.ico" --name FotoSync "%MYDIR%fotosync.py"
%PYINST% --onefile --console --clean --icon "%MYDIR%resources\fotosync.ico" --name FotoSync "%MYDIR%fotosync.py"



echo ---
echo ---


echo Sucessfully finished
goto :EXIT 




:ERR_MISSING_PYTHON
echo %PY_EXE_DIR% wasn't found. Please make sure python is installed and working.
goto :EXIT 

:ERR_MISSING_VIRTENV
echo virtualenv wasn't found. Please make sure virtualenv is installed and working.
goto :EXIT 

:EXIT
call "%VIRT_ENV_DIR%\scripts\deactivate.bat"
rmdir "%VIRT_ENV_DIR%" /s /q 

pause