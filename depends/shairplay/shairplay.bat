SETLOCAL

set DEPEND_NAME=shairplay
set DEPEND_VERSION=win32
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=https://codeload.github.com/Memphiz/shairplay/zip/win32

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate --output-document=%DEPEND_PACKAGE%.zip "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.zip
del /F /Q %DEPEND_PACKAGE%.zip
cd %DEPEND_PACKAGE%

copy /V /Y ..\shairplay-v%VS%0.vcxproj src\win\shairplay\shairplay\shairplay.vcxproj
msbuild src\win\shairplay\shairplay.sln /p:Configuration=Release;Platform=Win32 /t:Build

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y src\win\shairplay\Release\lib%DEPEND_NAME%-1.dll %BUILD_PATH%\bin\
copy /V /Y src\win\shairplay\Release\lib%DEPEND_NAME%-1.pdb %BUILD_PATH%\bin\
xcopy include\shairplay %BUILD_PATH%\include\shairplay /I /E /V /Y
copy /V /Y src\win\shairplay\Release\lib%DEPEND_NAME%-1.lib %BUILD_PATH%\lib\
copy /V /Y src\win\shairplay\Release\lib%DEPEND_NAME%-1.exp %BUILD_PATH%\lib\
