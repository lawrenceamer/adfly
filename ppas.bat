@echo off
SET THEFILE=C:\Users\0xsp\ADC\project1.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.0.4\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections    --entry=_mainCRTStartup    -o C:\Users\0xsp\ADC\project1.exe C:\Users\0xsp\ADC\link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
