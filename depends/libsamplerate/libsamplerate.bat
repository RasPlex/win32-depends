SETLOCAL

if "%VS%" == "12" (
  exit /b 0
)

set DEPEND_NAME=libsamplerate
set DEPEND_VERSION=0.1.8
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://www.mega-nerd.com/SRC/%DEPEND_PACKAGE%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.gz
del /F /Q %DEPEND_PACKAGE%.tar.gz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

copy /V /Y ..\Makefile-v%VS%0.msvc Win32\Makefile.msvc

nmake /f Win32\Makefile.msvc libsamplerate-0.dll

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y %DEPEND_NAME%-0.dll %BUILD_PATH%\bin\
copy /V /Y %DEPEND_NAME%-0.pdb %BUILD_PATH%\bin\
copy /V /Y src\samplerate.h %BUILD_PATH%\include\
copy /V /Y %DEPEND_NAME%-0.lib %BUILD_PATH%\lib\
copy /V /Y %DEPEND_NAME%-0.exp %BUILD_PATH%\lib\
