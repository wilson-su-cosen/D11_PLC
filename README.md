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

   - **實例解釋**：假設 `git log --oneline` 顯示以下內容：
     ```
     7f74fd3 修復 PLC 設定問題
     a1b2c3d 新增功能 A
     ```
     如果你想切換到 `7f74fd3`，請執行：
     ```bash
     git checkout 7f74fd3
     ```
     注意：請將 `<commit-hash>` 替換為實際的 commit ID，並刪除尖括號 `<>`。

3. 回到最新版本：

```bash
git checkout master
```

### 恢復特定檔案到某個版本

1. 查看檔案的歷史記錄：

```bash
git log --oneline -- "D11_PLC_0901_READ.gx3"
```

2. 恢復檔案到特定版本：

方式一：檢出版本但不覆蓋現有檔案

```bash
# 查看特定版本的檔案內容
git show <commit-hash>:"D11_PLC_0901_READ.gx3"

# 將特定版本的檔案存為另一個檔案
git show <commit-hash>:"D11_PLC_0901_READ.gx3" > "D11_PLC_0901_READ_old.gx3"
```

   - **實例解釋**：假設 `git log --oneline -- "D11_PLC_0901_READ.gx3"` 顯示以下內容：
     ```
     7f74fd3 修復 PLC 設定問題
     a1b2c3d 新增功能 A
     ```
     如果你想檢出 `7f74fd3` 的版本，並存為另一個檔案，請執行：
     ```bash
     git show 7f74fd3:"D11_PLC_0901_READ.gx3" > "D11_PLC_0901_READ_old.gx3"
     ```
     注意：請將 `<commit-hash>` 替換為實際的 commit ID，並刪除尖括號 `<>`。

方式二：直接覆蓋恢復

```bash
# 恢復檔案到特定版本
git checkout <commit-hash> -- "D11_PLC_0901_READ.gx3"

# 提交變更
git add "D11_PLC_0901_READ.gx3"
git commit -m "[YYYY/MM/DD] 恢復 D11_PLC_0901_READ.gx3 到版本 <commit-hash>"
```

   - **實例解釋**：假設你想直接恢復 `7f74fd3` 的版本，請執行：
     ```bash
     git checkout 7f74fd3 -- "D11_PLC_0901_READ.gx3"
     ```
     然後提交變更：
     ```bash
     git add "D11_PLC_0901_READ.gx3"
     git commit -m "[2025/09/05] 恢復 D11_PLC_0901_READ.gx3 到版本 7f74fd3"
     ```
     注意：請將 `<commit-hash>` 替換為實際的 commit ID，並刪除尖括號 `<>`。

### 注意：`git checkout <commit-hash>` 的影響

如果執行 `git checkout <commit-hash>` **沒有指定檔名**，Git 會將整個工作目錄切換到該版本的狀態，這包括所有檔案（例如 `README.md` 和其他檔案）都會恢復到該版本。

#### 如何避免影響其他檔案？

如果你只想恢復特定檔案，請務必指定檔名，例如：
```bash
git checkout <commit-hash> -- "D11_PLC_0901_READ.gx3"
```
這樣只會恢復 `D11_PLC_0901_READ.gx3` 到指定版本，而不影響其他檔案。

#### 如果不小心恢復了整個目錄怎麼辦？

1. 回到最新版本：
```bash
git checkout master
```

2. 如果有未提交的變更，還原工作目錄：
```bash
git reset --hard
```

這樣可以確保其他檔案不會被意外修改。

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

## 使用 VS Code 瀏覽本檔案

1. 安裝 [Visual Studio Code](https://code.visualstudio.com/)
2. 安裝 Office Viewer 插件：
   - 在 VS Code 的擴展市場搜尋 "Office Viewer"，並點擊安裝
3. 開啟本專案資料夾，點擊 `README.md` 即可瀏覽

## 注意事項

1. 使用 Git LFS 管理 .gx3 檔案，避免儲存庫過大
2. 建議定期提交更新，並附上清楚的說明
3. 恢復檔案時，請先確認是否需要備份現有檔案，避免資料遺失
