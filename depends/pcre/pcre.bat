SETLOCAL

if "%VS%" == "11" (
  exit /b 0
)

set DEPEND_NAME=pcre
set DEPEND_VERSION=8.40
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/%DEPEND_PACKAGE%.zip

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.zip
del /F /Q %DEPEND_PACKAGE%.zip
cd %DEPEND_PACKAGE%
mkdir build
cd build

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=%BUILD_PATH% -DPCRE_BUILD_PCREGREP=OFF -DPCRE_BUILD_TESTS=OFF -DPCRE_MATCH_LIMIT_RECURSION=1500 -DPCRE_NEWLINE=ANYCRLF -DPCRE_NO_RECURSE=ON -DPCRE_SUPPORT_JIT=ON -DPCRE_SUPPORT_UNICODE_PROPERTIES=ON -DPCRE_SUPPORT_UTF=ON -DCMAKE_C_FLAGS_RELWITHDEBINFO="/MD /Z7 /O2 /Ob1 /D NDEBUG" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="/MD /Z7 /O2 /Ob1 /D NDEBUG" ..
nmake install

ping 127.0.0.1 -n 2 -w 1000 > nul

rmdir /S /Q %BUILD_PATH%\man
rmdir /S /Q %BUILD_PATH%\share
