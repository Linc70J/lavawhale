# Docker

快速啟動
--------------

  > 初始化設定

  ```
  make init-fpm
  or
  make init-swoole
  ```
  
  > 請為專案設定image名稱
  
  ```
  COMPOSE_PROJECT_NAME={專案名稱}
  ```
  
  > 啟動docker
  
  ```
  docker-compose up -d
  ```
--------------

如何開啟或關閉
--------------

  > 開啟Docker
  
  ```
  docker-compose up -d
  ```

  > 關閉Docker
  
  ```
  docker-compose down
  ```