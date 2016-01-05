SETLOCAL

set DEPEND_NAME=boost
set DEPEND_VERSION=1_60_0
set DEPEND_PACKAGE=%DEPEND_NAME%_%DEPEND_VERSION%
set DEPEND_URL=http://prdownloads.sourceforge.net/boost/boost/1.60.0/%DEPEND_PACKAGE%.7z

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.7z
del /F /Q %DEPEND_PACKAGE%.7z
cd %DEPEND_PACKAGE%

call bootstrap.bat
b2 toolset=msvc-11.0 variant=debug link=static --with-thread --with-date_time --with-regex --with-random
b2 toolset=msvc-11.0 variant=release link=static --with-thread --with-date_time --with-regex --with-random

ping 127.0.0.1 -n 2 -w 1000 > nul

xcopy boost %BUILD_PATH%\include\boost /I /E /V /Y
xcopy stage\lib\*.lib %BUILD_PATH%\lib\ /I /E /V /Y
