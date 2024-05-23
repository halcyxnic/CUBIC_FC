:: turn console feedback off
@echo off

:: count arguments and exit if no arguments are passed
IF [%1] == [] (
    echo Please provide more than one argument. Arguments can be found using "%0 help"
    goto EOF
)

:: save first argument as the command
SET _command=%1

:: branch to different parts of file based on command
IF [%_command%]==[all] GOTO ALL
IF [%_command%]==[help] GOTO HELP
IF [%_command%]==[altium] GOTO ALTIUM
IF [%_command%]==[sw] GOTO SW

echo Invalid argument. Arguments can be found using "%0 help"
GOTO EOF

:: ============================= HELP =============================

:HELP

:: print out all commands
echo help           Displays this message
echo all            Pushes all local changes to repository
echo altium         Pushes local Altium changes to repository
echo sw             (WIP) Pushes local software changes to repository
goto EOF

:: ============================= ALL =============================

:ALL

:: remove history directories
IF exist .\Altium\CUBIC_FC_Project\History\ (
    echo Removing History folder from Project files...
    rmdir .\Altium\CUBIC_FC_Project\History\ /s /q
)

IF exist .\Altium\CUBIC_FC_Parts\History\ (
    echo Removing History folder from Library files...
    rmdir .\Altium\CUBIC_FC_Parts\History\ /s /q
)

:: prompt user for input
:input_message
set /p commit_message=Enter your commit message: 

if "%commit_message%"=="" (
    echo Commit message cannot be empty. Please try again.
    goto input_message
)

:: perform git upload
git add .
git commit -m "%commit_message%"
git push -u origin main

:: confirm success
echo.
echo.
echo Commit Successful!
goto EOF

:: ============================= ALTIUM =============================

:ALTIUM

:: remove the history directory (if it exists) in both folders
IF exist .\Altium\CUBIC_FC_Project\History\ (
    echo Removing History folder from Project files...
    rmdir .\Altium\CUBIC_FC_Project\History\ /s /q
)

IF exist .\Altium\CUBIC_FC_Parts\History\ (
    echo Removing History folder from Library files...
    rmdir .\Altium\CUBIC_FC_Parts\History\ /s /q
)

:: prompt user for input
:input_message
set /p commit_message=Enter your commit message: 

if "%commit_message%"=="" (
    echo Commit message cannot be empty. Please try again.
    goto input_message
)

:: perform git upload
git add "Altium"
git commit -m "%commit_message%"
git push -u origin main

:: confirm success
echo.
echo.
echo Commit Successful!
goto EOF

:: ============================= END OF FILE =============================
:EOF
SET _command=