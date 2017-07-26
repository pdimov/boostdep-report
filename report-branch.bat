@REM Copyright 2014-2017 Peter Dimov
@REM Distributed under the Boost Software License, Version 1.0.

SET BOOSTDEP=dist\bin\boostdep.exe

FOR /f %%i IN ('git rev-parse HEAD') DO @SET REV=%%i
FOR /f %%i IN ('git rev-parse --short HEAD') DO @SET SHREV=%%i
FOR /f %%i IN ('git rev-parse --abbrev-ref HEAD') DO @SET BRANCH=%%i

SET PREFIX="<div class='logo'><div class='upper'>boost</div><div class='lower'>Dependency Report</div><div class='description'>%BRANCH%-%SHREV%, %DATE% %TIME%</div></div><hr />"

SET OPTIONS=--html-stylesheet ../report.css --html-prefix %PREFIX%

SET OUTDIR=%1

mkdir %OUTDIR%

%BOOSTDEP% --list-modules > %OUTDIR%\list-modules.txt

%BOOSTDEP% %OPTIONS% --html-title "Boost Module Overview" --html --module-overview > %OUTDIR%\module-overview.html
%BOOSTDEP% %OPTIONS% --html-title "Boost Module Levels" --html --module-levels > %OUTDIR%\module-levels.html
%BOOSTDEP% %OPTIONS% --html-title "Boost Module Weights" --html --module-weights > %OUTDIR%\module-weights.html

FOR /f %%i IN (%OUTDIR%\list-modules.txt) DO %BOOSTDEP% --html-title "Boost Dependency Report for %%i" %OPTIONS% --html --primary %%i --secondary %%i --reverse %%i > %OUTDIR%\%%i.html
