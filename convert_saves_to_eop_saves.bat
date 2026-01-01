@echo off
setlocal enabledelayedexpansion

:: Check if saves folder exists
if not exist "saves" (
    echo Error: saves folder not found
    pause
    exit /b 1
)

:: Create backup of saves folder
if not exist "saves_backup" mkdir "saves_backup"
echo Creating backup...
copy "saves\*.sav" "saves_backup\" >nul 2>&1

:: Process each .sav file in saves folder
for %%f in (saves\*.sav) do (
    echo Processing %%f...
    
    :: Get filename without extension
    set "filename=%%~nf"
    
    :: Rename original file
    ren "%%f" "M2TWEOPTEMPgameSaveDONTTOUCHTHISFILE.sav"
    
    :: Create zip archive with renamed file inside
    powershell -command "Compress-Archive -Path 'saves\M2TWEOPTEMPgameSaveDONTTOUCHTHISFILE.sav' -DestinationPath 'saves\!filename!.zip' -Force"
    
    :: Rename zip to sav
    ren "saves\!filename!.zip" "!filename!.sav"
    
    :: Remove the temporary renamed file
    del "saves\M2TWEOPTEMPgameSaveDONTTOUCHTHISFILE.sav"
)

echo Processing complete!
pause