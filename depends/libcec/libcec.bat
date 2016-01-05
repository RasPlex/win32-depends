SETLOCAL

set DEPEND_NAME=libcec
set DEPEND_VERSION=2.2.0
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%-repack
set DEPEND_URL=https://github.com/Pulse-Eight/libcec/archive/%DEPEND_PACKAGE%.zip

IF EXIST %DEPEND_NAME%-%DEPEND_PACKAGE% rmdir /S /Q %DEPEND_NAME%-%DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.zip
del /F /Q %DEPEND_PACKAGE%.zip
cd %DEPEND_NAME%-%DEPEND_PACKAGE%

copy /V /Y ..\libcec.rc project\libcec\
copy /V /Y ..\libcec.vcxproj project\libcec\
msbuild project\libcec.sln /p:Configuration=Release;Platform=x86 /t:libcec

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y build\%DEPEND_NAME%.dll %BUILD_PATH%\bin\
copy /V /Y build\%DEPEND_NAME%.pdb %BUILD_PATH%\bin\
xcopy include %BUILD_PATH%\include\%DEPEND_NAME% /I /E /V /Y
copy /V /Y build\%DEPEND_NAME%.lib %BUILD_PATH%\lib\
copy /V /Y build\%DEPEND_NAME%.exp %BUILD_PATH%\lib\
