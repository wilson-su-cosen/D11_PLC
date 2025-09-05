@echo off
REM 設定命令提示字元的編碼為 UTF-8
chcp 65001 > nul

REM 快速將當前目錄的檔案加入、提交並推送到遠端

REM 顯示即將上傳的檔案
echo 以下是即將上傳的檔案：
git status

REM 詢問是否繼續
set /p confirm=確定要上傳嗎？(Y/N): 
if /i "%confirm%" neq "Y" goto :end

REM 設定時間戳記
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set YYYY=%datetime:~0,4%
set MM=%datetime:~4,2%
set DD=%datetime:~6,2%
set HH=%datetime:~8,2%
set Min=%datetime:~10,2%

REM 取得當前日期作為標題
set current_date=%YYYY%/%MM%/%DD%

REM 詢問更新說明
set /p update_note=請輸入更新說明（直接按 Enter 跳過）: 

if not "%update_note%"=="" (
    REM 檢查是否已有今天的日期標題
    findstr /c:"## %current_date%" UPDATE.md > nul
    if errorlevel 1 (
        REM 如果沒有今天的日期，加入新的日期標題
        echo ## %current_date%>> UPDATE.md
    )
    REM 只加入更新說明，不加時間戳
    echo - %update_note%>> UPDATE.md
    echo.>> UPDATE.md
)

REM 加入當前目錄的檔案（會自動忽略 .gitignore 中的 OLD 目錄）
git add .

REM 提交並推送（commit 訊息包含完整日期和時間）
git commit -m "[%YYYY%/%MM%/%DD% %HH%:%Min%] 更新 %update_note%"
git push

REM 開啟專案的 GitHub 網頁
start https://github.com/wilson-su-cosen/D11_PLC

:end
if /i "%confirm%" neq "Y" (
    echo 已取消上傳
)
pause