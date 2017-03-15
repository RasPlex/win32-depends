SETLOCAL

if "%VS%" == "11" (
  exit /b 0
)

set DEPEND_NAME=dnssd
set DEPEND_VERSION=541
set DEPEND_PACKAGE=mDNSResponder-%DEPEND_VERSION%
set DEPEND_URL=http://sources.openpht.tv/devel/mDNSResponder-%DEPEND_VERSION%.tar.gz

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.tar.gz
del /F /Q %DEPEND_PACKAGE%.tar.gz
%ZIP% x -y %DEPEND_PACKAGE%.tar
del /F /Q %DEPEND_PACKAGE%.tar
cd %DEPEND_PACKAGE%

%PATCH% -p1 < ../vc120.patch

msbuild mDNSResponder.sln /p:Configuration=Release;Platform=Win32 /t:DLL

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y mDNSShared\dns_sd.h %BUILD_PATH%\include\
copy /V /Y mDNSWindows\DLL\Win32\Release\dnssd.dll %BUILD_PATH%\bin\
copy /V /Y mDNSWindows\DLL\Win32\Release\dnssd.pdb %BUILD_PATH%\bin\
copy /V /Y mDNSWindows\DLL\Win32\Release\dnssd.lib %BUILD_PATH%\lib\
copy /V /Y mDNSWindows\DLL\Win32\Release\dnssd.exp %BUILD_PATH%\lib\
