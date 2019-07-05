# Docker

## 初始化環境建置

  > 載入docker模組
  
  ```
  git submodule add https://github.com/Linc70J/lavawhale.git docker
  ```
  
  cd 至 docker 資料夾在執行以下步驟：
  
  > 發布設定檔至指定位置
  
  ```
  make publish
  ```
  
## 使用教學

  以下使用教學將以develop版為例
  
  > 重新載入docker模組
  
  ```
  git submodule init
  git submodule update
  ```
  
  > 建立設定檔
  
  ```
  cp deploy/docker/.env.dev docker/.env
  cp deploy/docker/docker-compose.yml.dev docker/docker-compose.yml
  ```
  
  > 請為專案設定image名稱
  
  ```
  COMPOSE_PROJECT_NAME={專案名稱}
  ```
  
  > 設定Web Service
  
  使用php-fpm

  ```
  make setup-fpm
  ```
  
  或者使用swoole
  
  ```
  make setup-swoole
  ```
  
  PS. 如果你要使用swoole功能，你需要擴展 [laravel-swoole](https://github.com/swooletw/laravel-swoole) 套件，並完成相關設定

  > 設定Worker Service

  ```
  make setup-worker
  ```
    
  > 啟動
  
  ```
  docker-compose up -d
  ```