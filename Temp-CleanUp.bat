@echo off
rem Ensure the script runs with Admin privileges for the system temp folders to be successfully deleted.
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 04
    echo [ERROR] C:\Windows\Temp Requires Admin privileges.
    echo please right-click and "Run as Administrator!"
    echo Press Any Key To Exit.
    pause >nul
    exit /b 1
)

timeout /t 1 >nul

for /F %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"
set "Green=%ESC%[32m"
set "Red=%ESC%[31m"
set "Yellow=%ESC%[93m"

echo %Green%

echo =========================================================================================
echo                  %Yellow%A System Clean Up Tool For Temp Files Created By %Red%Omar-R00T%Green%
echo =========================================================================================
echo %Yellow%AUTHOR	                %Red%[Omar-R00T]
echo %Yellow%VERSION                 %Red%[v1.0.0]
echo %Yellow%REPOSITORY              %Red%https://github.com/Omar-R00T/Windows-Temp-Clean-Up-Tool
echo %Green%=========================================================================================
echo.

timeout /t 1 >nul

for %%G in ("%temp%" "C:\Windows\Temp") do (
    if exist "%%~G" (
        echo [PROCESSING]: %%~G...
        echo ---------------------------------------------
        
        rem Delete files safely (deleting only files that are 3 days and + old, while keeping newer ones just to be extra cautious to not delete active files.)
        forfiles /p "%%~G" /s /d -3 /c "cmd /c del /q /f \"@path\" >nul 2>&1 && echo [DELETED]: @file" 2>nul

        rem Cleans up empty subdirectories to not leave a mess in the future.
        for /f "delims=" %%x in ('dir /s /ad /b "%%~G" ^| sort /r') do (
            if /i not "%%x" == "%%~G" (
                rd "%%x" >nul 2>&1 && echo "%%x" has been deleted.
            )
        )
        echo ---------------------------------------------
        echo.
    )
)
timeout /t 1 >nul

echo =========================================================================================
echo                %Yellow%You Have Successfully Deleted %Red%Temp %Yellow%Files older than 3 days.%Green%
echo =========================================================================================
echo %Yellow%Press Any Key To %Red%Exit.
pause >nul