SETLOCAL

if "%VS%" == "11" (
  exit /b 0
)

set DEPEND_NAME=yajl
set DEPEND_VERSION=2.1.0
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=https://github.com/lloyd/yajl/archive/%DEPEND_VERSION%.zip

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_VERSION%.zip
del /F /Q %DEPEND_VERSION%.zip
cd %DEPEND_PACKAGE%
mkdir build
cd build

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=%BUILD_PATH% ..
nmake install

ping 127.0.0.1 -n 2 -w 1000 > nul

rmdir /S /Q %BUILD_PATH%\share
del /F /Q %BUILD_PATH%\lib\yajl.*
move %BUILD_PATH%\lib\yajl_s.lib %BUILD_PATH%\lib\yajl.lib
