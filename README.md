# Docker

## 快速啟動

  > 載入docker模組
  
  ```
  git submodule add https://github.com/Linc70J/lavawhale.git docker
  ```
  
  > 初始化設定
  
  使用php-fpm

  ```
  make init-fpm
  ```
  
  或者使用swoole
  
  ```
  make init-swoole
  ```
  
  PS. 如果你要使用swoole功能，你需要擴展 
[laravel-swoole](https://github.com/swooletw/laravel-swoole) 套件，並完成相關設定
  
  > 請為專案設定image名稱
  
  ```
  COMPOSE_PROJECT_NAME={專案名稱}
  ```
  
  > 啟動docker
  
  ```
  docker-compose up -d
  ```
  

##如何開啟或關閉

  > 開啟Docker
  
  ```
  docker-compose up -d
  ```

  > 關閉Docker
  
  ```
  docker-compose down
  ```