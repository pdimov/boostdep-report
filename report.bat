@REM Copyright 2017 Peter Dimov
@REM Distributed under the Boost Software License, Version 1.0.

rd /s/q temp

git clone --recursive https://github.com/boostorg/boost temp || exit /b
cd temp

cd tools\boostdep && git checkout develop && cd ..\.. || exit /b

b2 tools/boostdep/build || exit /b

rd /s/q ..\master
call ..\report-branch.bat ..\master

git checkout develop && git submodule update --init || exit /b

rd /s/q ..\develop
call ..\report-branch.bat ..\develop

cd ..
rd /s/q temp
