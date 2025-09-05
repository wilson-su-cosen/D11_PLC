@echo off
REM 快速將當前目錄的檔案加入、提交並推送到遠端

REM 顯示即將上傳的檔案
echo 以下是即將上傳的檔案：
git status

REM 詢問是否繼續
set /p confirm=確定要上傳嗎？(Y/N): 
if /i "%confirm%" neq "Y" goto :end

REM 加入當前目錄的檔案（會自動忽略 .gitignore 中的 OLD 目錄）
git add .

REM 設定時間戳記
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set YYYY=%datetime:~0,4%
set MM=%datetime:~4,2%
set DD=%datetime:~6,2%
set HH=%datetime:~8,2%
set Min=%datetime:~10,2%

REM 提交並推送
git commit -m "Update files - %YYYY%/%MM%/%DD% %HH%:%Min%"
git push

:end
if /i "%confirm%" neq "Y" (
    echo 已取消上傳
)
pause