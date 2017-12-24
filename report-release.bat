@REM Copyright 2017 Peter Dimov
@REM Distributed under the Boost Software License, Version 1.0.

@IF "%1" == "" ( ECHO Usage: report-release `tag' & exit /b 1 )

rd /s/q temp

git clone --recursive -b %1 --depth 1 https://github.com/boostorg/boost temp || exit /b
cd temp

b2 tools/boostdep/build || exit /b

rd /s/q ..\%1
call ..\report-branch.bat ..\%1

cd ..
rd /s/q temp

git add %1
git commit -m "Update report for %1"
REM git push
