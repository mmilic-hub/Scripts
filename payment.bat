@echo off
REM ----------------------------------------------------------------------
REM Payment service software Helper Script
REM This script performs several operations related to the Payment service software.
REM It checks for the pinpad connection, necessary files, and marker files,
REM and ensures the correct firmware is present.
REM ----------------------------------------------------------------------

REM Set the current working directory to mypath
set mypath=%cd%

REM Kill the Payment service software if it's running
taskkill /IM "Payment service software.exe" /F

REM Check if the pinpad is connected (COM ports between 16 and 20)
echo Checking if the pinpad is connected
wmic path Win32_PnPEntity where "Caption like '%%COM[(16)-(20)]%%'" get Caption

echo ----------------------------------------------------------------------
echo Checking required files...

REM List of files to check for in the current directory
set "filelist=necessary file1.txt necessary file.dll necessary file1.ini"

REM Check each file in the list
for %%f in (%filelist%) do (
    if exist "%mypath%\%%f" (
        echo %%f is present
    ) else (
        echo %%f is missing.
    )
)

echo ----------------------------------------------------------------------
echo Checking if the Firmware file is present...

REM List of firmware files to check for
set "firmware=FW.zip FW2.zip"

REM Check for the existence of firmware files and rename them
for %%f in (%firmware%) do (
    if exist "%mypath%\%%f" (
        echo %%f is present
        ren %%f renamed%%f
        echo Firmware file has been renamed to renamed%%f, so that Pinpad reload can be done.
    )
)

echo ----------------------------------------------------------------------
echo Checking journal files and pinpad serial number...

REM List of journal files to check for
set "journal=file1.txt file2.txt file3.txt"

REM Check each journal file and search for the PinPadSerialNumber
for %%f in (%journal%) do (
    if exist "%mypath%\%%f" (
        echo %%f is present
        dir %%f
        del "old%%f"
        echo Checking pinpad serial number
        echo ---------------------------------------
        FiNDSTR /i "PinPadSerialNumber" "%%f"
        ren %%f old%%f
        del "%mypath%\oldUpdate.ini"
    )
)

REM Start the Aloha Payment Service
start "" %LOCALDIR%\..\folder\Payment service software runasexe nowindow

pause
