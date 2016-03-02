SETLOCAL

set DEPEND_NAME=openssl
set DEPEND_VERSION=1.0.2g
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=https://www.openssl.org/source/%DEPEND_PACKAGE%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.gz
del /F /Q %DEPEND_PACKAGE%.tar.gz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

perl Configure VC-WIN32 no-asm no-comp no-dso --prefix=%BUILD_PATH%
call ms\do_ms
nmake -f ms\ntdll.mak

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y out32dll\libeay32.dll %BUILD_PATH%\bin\
copy /V /Y out32dll\libeay32.pdb %BUILD_PATH%\bin\
copy /V /Y out32dll\ssleay32.dll %BUILD_PATH%\bin\
copy /V /Y out32dll\ssleay32.pdb %BUILD_PATH%\bin\
xcopy inc32\openssl %BUILD_PATH%\include\openssl /I /E /V /Y
copy /V /Y out32dll\libeay32.lib %BUILD_PATH%\lib\
copy /V /Y out32dll\libeay32.exp %BUILD_PATH%\lib\
copy /V /Y out32dll\ssleay32.lib %BUILD_PATH%\lib\
copy /V /Y out32dll\ssleay32.exp %BUILD_PATH%\lib\
