@echo off

echo ++ Set variables needed ++
set VIRT_ENV_NAME=fotosync
set PYP=G:\programs\WPy64-3950\python-3.9.5.amd64
echo ---
echo ---

echo ++ Check python ++
if not exist %PYP% goto :ERR_MISSING_PYTHON
echo "%PYP%\Scripts\pip" install virtualenv
"%PYP%\Scripts\pip" install virtualenv
::where virtualenv >nul 2>nul
::if %ERRORLEVEL% NEQ 0 goto :ERR_MISSING_VIRTENV
echo ---
echo ---

echo ++ Prepare virtual environment ++
set VIRT_ENV_DIR=%TEMP%\%VIRT_ENV_NAME%
if exist "%VIRT_ENV_DIR%" rmdir "%VIRT_ENV_DIR%" /s /q 
::"%PYP%\Scripts\virtualenv" --python "%PYP%\python.exe" %VIRT_NAME%
echo "%PYP%\Scripts\virtualenv" --python "%PYP%\python.exe" "%VIRT_ENV_DIR%"
"%PYP%\Scripts\virtualenv" --python "%PYP%\python.exe" "%VIRT_ENV_DIR%"
echo call "%VIRT_ENV_DIR%\scripts\activate.bat"
call "%VIRT_ENV_DIR%\scripts\activate.bat"
echo ---
echo ---

echo ++ Install needed packages in virtual env ++
set MYDIR=%~dp0
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
echo %PYP% wasn't found. Please make sure python is installed and working.
goto :EXIT 

:ERR_MISSING_VIRTENV
echo virtualenv wasn't found. Please make sure virtualenv is installed and working.
goto :EXIT 

:EXIT
call "%VIRT_ENV_DIR%\scripts\deactivate.bat"
::rmdir "%VIRT_ENV_DIR%" /s /q 

pause