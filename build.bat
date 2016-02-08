@ECHO OFF
cd /D %~dp0

SETLOCAL

set BUILD_PATH=%CD%\plex-depends
IF EXIST plex-depends rmdir /S /Q plex-depends
mkdir plex-depends
mkdir plex-depends\bin
mkdir plex-depends\include
mkdir plex-depends\lib

if "%WindowsSdkDir%" == "" (
  call "%VS110COMNTOOLS%vsvars32.bat"
)

if "%VisualStudioVersion%" == "" (
  set VisualStudioVersion=11.0
)

set VS=%VisualStudioVersion:~0,2%
if "%VS%" == "11" (
  set VSYEAR=2012
)
if "%VS%" == "12" (
  set VSYEAR=2013
)

set WGET=%CD%\tools\wget
set PATCH=%CD%\tools\patch
set ZIP=%CD%\tools\7z\7za

FOR /F "eol=; tokens=1" %%f IN (depends\depends.txt) DO (
  echo Building %%f
  cd /D %~dp0\depends\%%f
  call %%f.bat
  echo.
)

cd /D %~dp0

tools\7z\7za.exe a plex-depends-v%VS%0.7z plex-depends\
