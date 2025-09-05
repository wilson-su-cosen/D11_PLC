# D11 PLC 專案 Git 操作說明

## 自動上傳（使用批次檔）

直接執行 `git_push.bat`，會自動：

- 加入當前目錄的 .gx3 檔案
- 提交變更（包含時間戳記）
- 推送到遠端

## 手動操作方式

### 基本上傳流程

```bash
# 加入檔案
git add *.gx3

# 提交（快速帶入時間）
git commit -m "Update $(Get-Date -Format 'yyyy/MM/dd HH:mm')"

# 推送到遠端
git push
```

### 下載特定版本

1. 查看版本歷史：

```bash
git log --oneline
```

2. 切換到特定版本：

```bash
git checkout <commit-hash>
```

3. 回到最新版本：

```bash
git checkout master
```

## Git LFS 操作

由於專案包含大型二進位檔案（.gx3），使用 Git LFS 管理：

```bash
# 追蹤 .gx3 檔案
git lfs track "*.gx3"

# 確認 LFS 狀態
git lfs ls-files
```

## 其他常用指令

```bash
# 查看狀態
git status

# 拉取最新更新
git pull

# 查看分支
git branch

# 建立新分支
git checkout -b <branch-name>
```

## 注意事項

1. 使用 Git LFS 管理 .gx3 檔案，避免儲存庫過大
2. 建議定期提交更新，並附上清楚的說明
