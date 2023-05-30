@echo off

echo Build Started

asm68k /k /p /o ae- sonic2alpha.asm, s2built.bin
IF NOT EXIST s2built.bin goto LABLERR
rompad.exe s2built.bin
fixheadr.exe s2built.bin

echo Build Successful!

goto LABLDONE

:LABLERR
echo There was a problem building. Please check through the error message and fix the error.
pause
:LABLDONE
pause