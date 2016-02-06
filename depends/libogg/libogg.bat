SETLOCAL

set DEPEND_NAME=libogg
set DEPEND_VERSION=1.3.2
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://downloads.xiph.org/releases/ogg/%DEPEND_PACKAGE%.tar.xz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.xz
del /F /Q %DEPEND_PACKAGE%.tar.xz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

xcopy ..\VS%VSYEAR% win32\VS%VSYEAR% /I /E /V /Y
msbuild win32\VS%VSYEAR%\libogg_dynamic.sln /t:Build /p:Configuration=Release;Platform=Win32

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y win32\VS%VSYEAR%\Win32\Release\%DEPEND_NAME%.dll %BUILD_PATH%\bin\
copy /V /Y win32\VS%VSYEAR%\Win32\Release\%DEPEND_NAME%.pdb %BUILD_PATH%\bin\
mkdir %BUILD_PATH%\include\ogg\
copy /V /Y include\ogg\ogg.h %BUILD_PATH%\include\ogg\
copy /V /Y include\ogg\os_types.h %BUILD_PATH%\include\ogg\
copy /V /Y win32\VS%VSYEAR%\Win32\Release\%DEPEND_NAME%.lib %BUILD_PATH%\lib\
copy /V /Y win32\VS%VSYEAR%\Win32\Release\%DEPEND_NAME%.exp %BUILD_PATH%\lib\
