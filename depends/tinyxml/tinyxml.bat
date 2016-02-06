SETLOCAL

set DEPEND_NAME=tinyxml
set DEPEND_VERSION=2_6_2
set DEPEND_PACKAGE=%DEPEND_NAME%_%DEPEND_VERSION%
set DEPEND_URL=http://downloads.sourceforge.net/project/tinyxml/tinyxml/2.6.2/%DEPEND_PACKAGE%.zip

IF EXIST %DEPEND_NAME% rmdir /S /Q %DEPEND_NAME%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.zip
del /F /Q %DEPEND_PACKAGE%.zip
cd %DEPEND_NAME%

copy /V /Y ..\tinyxmlSTL-v%VS%0.vcxproj tinyxmlSTL.vcxproj
msbuild tinyxml.sln /p:Configuration=Debug;Platform=Win32 /t:tinyxmlSTL
msbuild tinyxml.sln /p:Configuration=Release;Platform=Win32 /t:tinyxmlSTL

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y tinystr.h %BUILD_PATH%\include\
copy /V /Y tinyxml.h %BUILD_PATH%\include\
copy /V /Y DebugtinyxmlSTL\tinyxmlSTLd.lib %BUILD_PATH%\lib\tinyxmlSTLd.lib
copy /V /Y DebugtinyxmlSTL\tinyxmlstld.pdb %BUILD_PATH%\lib\tinyxmlSTLd.pdb
copy /V /Y ReleasetinyxmlSTL\tinyxmlSTL.lib %BUILD_PATH%\lib\tinyxmlSTL.lib
copy /V /Y ReleasetinyxmlSTL\tinyxmlstl.pdb %BUILD_PATH%\lib\tinyxmlSTL.pdb
