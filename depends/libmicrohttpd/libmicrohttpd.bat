SETLOCAL

if "%VS%" == "11" (
  exit /b 0
)

set DEPEND_NAME=libmicrohttpd
set DEPEND_VERSION=0.9.51
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://ftp.gnu.org/gnu/libmicrohttpd/%DEPEND_PACKAGE%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.gz
del /F /Q %DEPEND_PACKAGE%.tar.gz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

%PATCH% -p1 < ../vc120-config.patch

msbuild w32\VS2013\libmicrohttpd.sln /p:Configuration=Release-dll;Platform=Win32 /t:libmicrohttpd

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y w32\VS2013\Output\microhttpd.h %BUILD_PATH%\include\
copy /V /Y w32\VS2013\Output\libmicrohttpd-dll.dll %BUILD_PATH%\bin\
copy /V /Y w32\VS2013\Output\libmicrohttpd-dll.exp %BUILD_PATH%\lib\
copy /V /Y w32\VS2013\Output\libmicrohttpd-dll.lib %BUILD_PATH%\lib\
copy /V /Y w32\VS2013\Output\libmicrohttpd-dll.pdb %BUILD_PATH%\lib\
