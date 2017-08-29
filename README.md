# WiFi Spot explorer API

クエリパラメータ radius, latitude, longitude によって指定した緯度latitude経度longitudeから半径raidusメートル以内にあるwifiスポットをjsonファイルとして返してくれるAPIです。

## 環境
ruby 2.4.0

## セットアップ
1. このリポジトリをクローン

  ```
  $ git clone https://github.com/johnta0/wifi-spot-api
  ```

2. ライブラリのインストール

  ```
  $ bundle install
  ```
3. geokit-rails の設定

  ```
  $ rails g geokit_rails:install
  ```

4. マイグレーション & データを入れる
  ```
  $ rails db:migrate && rails db:seed
  ```
CSVファイルからDBにWiFiスポットのデータを入れます。データ量がかなり多いので時間がかかります。

## 動作
  ```
  $ rails s
  ```
  でサーバーを立ち上げて、
  ```
   http://localhost:3000/api/v1/spots?radius=RADIUS_HERE&longitude=LONGITUDE_HERE&latitude=LATITUDE_HERE
  ```
  を叩くと結果が返ってきます。radiusの値を省略した場合には、指定した緯度経度から 500m 以内のwifi spot を探します。

## Heroku
[Herokuリンクはこちら]()
