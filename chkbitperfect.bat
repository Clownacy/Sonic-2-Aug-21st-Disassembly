@echo OFF

REM // build the ROM
call build

REM  // run fc against the original ROM
echo -------------------------------------------------------------
if exist s2built.bin ( fc /b s2built.bin sonic2alpha.bin
) else echo s2built.bin does not exist, probably due to an assembly error

REM // if someone ran this from Windows Explorer, prevent the window from disappearing immediately
pause
