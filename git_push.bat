@echo off
REM 快速將當前目錄的 .gx3 檔案加入、提交並推送到遠端
git add .
REM 明確排除 OLD 目錄
git reset -- OLD/*.gx3
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set YYYY=%datetime:~0,4%
set MM=%datetime:~4,2%
set DD=%datetime:~6,2%
set HH=%datetime:~8,2%
set Min=%datetime:~10,2%
git commit -m "Update gx3 files - %YYYY%/%MM%/%DD% %HH%:%Min%"
git push
pause