SETLOCAL

set DEPEND_NAME=zlib
set DEPEND_VERSION=1.2.11
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://zlib.net/%DEPEND_PACKAGE%.tar.xz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.xz
del /F /Q %DEPEND_PACKAGE%.tar.xz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

nmake -f win32/Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj" testdll

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y zlib1.dll %BUILD_PATH%\bin\
copy /V /Y zlib1.pdb %BUILD_PATH%\bin\
copy /V /Y zlib.h %BUILD_PATH%\include\
copy /V /Y zconf.h %BUILD_PATH%\include\
copy /V /Y zutil.h %BUILD_PATH%\include\
copy /V /Y zdll.lib %BUILD_PATH%\lib\zlib.lib
copy /V /Y zdll.exp %BUILD_PATH%\lib\zlib.exp
