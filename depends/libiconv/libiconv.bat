SETLOCAL

if "%VS%" == "11" (
  exit /b 0
)

set DEPEND_NAME=libiconv
set DEPEND_VERSION=1.14
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://ftp.gnu.org/gnu/libiconv/%DEPEND_PACKAGE%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.gz
del /F /Q %DEPEND_PACKAGE%.tar.gz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%
%ZIP% x -y ../vcproject.7z

msbuild vcproject\libiconv-1.14.sln /p:Configuration=Release;Platform=Win32

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y vcproject\iconv.h %BUILD_PATH%\include\
copy /V /Y vcproject\Release\libiconv.lib %BUILD_PATH%\lib\
copy /V /Y vcproject\Release\libiconv.pdb %BUILD_PATH%\lib\
