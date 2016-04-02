SETLOCAL EnableDelayedExpansion

set DEPEND_NAME=sqlite3
set DEPEND_VERSION=3.9.2
set DEPEND_PACKAGE=sqlite-amalgamation-3090200
set DEPEND_URL=https://www.sqlite.org/2015/%DEPEND_PACKAGE%.zip
if "%VS%" == "12" (
  set DEPEND_VERSION=3.12.0
  set DEPEND_PACKAGE=sqlite-amalgamation-3120000
  set DEPEND_URL=https://www.sqlite.org/2016/!DEPEND_PACKAGE!.zip
)

IF EXIST %DEPEND_PACKAGE% rmdir /S /Q %DEPEND_PACKAGE%
%WGET% --no-check-certificate "%DEPEND_URL%"
%ZIP% x -y %DEPEND_PACKAGE%.zip
del /F /Q %DEPEND_PACKAGE%.zip
cd %DEPEND_PACKAGE%

copy /V /Y ..\sqlite3.def sqlite3.def
cl -W3 -DSQLITE_OS_WIN=1 -fp:precise -MD -DNDEBUG -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -DSQLITE_THREADSAFE=1 -DSQLITE_WIN32_MALLOC=1 -DSQLITE_THREAD_OVERRIDE_LOCK=-1 -DSQLITE_TEMP_STORE=2 -DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_RTREE=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 -DSQLITE_MAX_TRIGGER_DEPTH=100  -Ox -Ob2 -Oi -Ot -Oy -GL -Gy -GS- -arch:SSE2 -Zi -c -Fdsqlite3.pdb -Fosqlite3.obj sqlite3.c
link /DLL /DEBUG /LTCG /OPT:REF /OPT:ICF /DEF:sqlite3.def /OUT:sqlite3.dll sqlite3.obj

ping 127.0.0.1 -n 2 -w 1000 > nul

copy /V /Y sqlite3.dll %BUILD_PATH%\bin\
copy /V /Y sqlite3.pdb %BUILD_PATH%\bin\
copy /V /Y sqlite3.h %BUILD_PATH%\include\
copy /V /Y sqlite3ext.h %BUILD_PATH%\include\
copy /V /Y sqlite3.lib %BUILD_PATH%\lib\
copy /V /Y sqlite3.exp %BUILD_PATH%\lib\
