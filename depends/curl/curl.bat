SETLOCAL

set DEPEND_NAME=curl
set DEPEND_VERSION=7.46.0
set DEPEND_PACKAGE=%DEPEND_NAME%-%DEPEND_VERSION%
set DEPEND_URL=http://curl.haxx.se/download/%DEPEND_PACKAGE%.tar.lzma

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.lzma
del /F /Q %DEPEND_PACKAGE%.tar.lzma
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

rem TODO patch MakefileBuild.vc adding /DUSE_SYNC_DNS
rem %PATHC% -p1 < ..\use-sync-dns.patch

copy /V /Y ..\MakefileBuild.vc winbuild\
cd winbuild
nmake /f Makefile.vc mode=dll VC=%VS% WITH_DEVEL=%BUILD_PATH% WITH_SSL=dll WITH_ZLIB=dll ENABLE_SSPI=no GEN_PDB=yes DEBUG=no MACHINE=x86

ping 127.0.0.1 -n 2 -w 1000 > nul

cd ..\builds\libcurl-vc%VS%-x86-release-dll-ssl-dll-zlib-dll-ipv6
copy /V /Y bin\libcurl.dll %BUILD_PATH%\bin\
copy /V /Y lib\libcurl.pdb %BUILD_PATH%\bin\
xcopy include\curl %BUILD_PATH%\include\curl /I /E /V /Y
copy /V /Y lib\libcurl.lib %BUILD_PATH%\lib\
copy /V /Y lib\libcurl.exp %BUILD_PATH%\lib\
