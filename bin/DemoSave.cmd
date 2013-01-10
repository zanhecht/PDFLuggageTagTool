@echo off
FileToSave "set fname=" ".\*.txt" "Select target file" "Blah.txt" /overwritePrompt > %temp%\temp.cmd
echo Errorlevel: %errorlevel%
if errorlevel 1 goto :end

call %temp%\temp.cmd
echo.
echo Fname=%fname%
echo.

:end
pause
