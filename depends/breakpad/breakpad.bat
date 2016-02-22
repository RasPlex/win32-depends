SETLOCAL

set DEPEND_NAME=breakpad
rem set DEPEND_VERSION=chrome_49
set DEPEND_VERSION=84d37160a74e0ce627a6fedf3395a7480450f4c1
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=https://chromium.googlesource.com/breakpad/breakpad/+archive/%DEPEND_VERSION%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_VERSION%.tar.gz
del /F /Q %DEPEND_VERSION%.tar.gz
%ZIP% x -y -o%DEPEND_PACKAGE% %DEPEND_VERSION%.tar
del /F /Q %DEPEND_VERSION%.tar
cd %DEPEND_PACKAGE%

%PATCH% -p1 < ../cmake.patch

mkdir build
cd build

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=%BUILD_PATH% ..
nmake install
