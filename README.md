# WiFi Spot explorer API

クエリパラメータ radius, latitude, longitude , limitによって指定した緯度latitude経度longitudeから半径raidusメートル以内にあるwifiスポットをlimit件、jsonファイルとして返してくれるAPIです。

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

## 機能

  ### 通常機能
  ```$ rails s```

  でサーバーを立ち上げて、

  ```http://localhost:3000/api/v1/spots?radius=1000&longitude=139.767052&latitude=35.681167&limit=10```

  を叩くと「東京駅周辺1000mにあるwifiスポットを、10件まで制限」した結果が返ってきます。radiusの値を省略した場合には、指定した緯度経度から 500m 以内のwifi spot を探します。また、limitパラメータを省略した場合にはレスポンス件数を5件に制限します。limit に０以下の整数を入力した場合、デフォルト値のlimit=5 として処理されます。

  ### 検索機能
  ```/api/v1/spots/search?word=XXX ``` のXXX部分のワードを含む住所を検索して、ヒットした情報を表示します。また、limitパラメータで表示件数を制限することも
  可能です。limitパラメータを指定しなかった場合は5件に制限して表示します。

## Heroku
Heroku URL: https://wifi-spot-explorer.herokuapp.com/

[東京駅周辺1000mにあるwifiスポットを、10件まで制限した結果](https://wifi-spot-explorer.herokuapp.com/api/v1/spots?radius=1000&longitude=139.767052&latitude=35.681167&limit=10)

["渋谷"で検索した結果](https://wifi-spot-explorer.herokuapp.com/api/v1/spots/search?word=渋谷)


## 開発に際して参考にしたリンク(漏れあり）

* [使えるRSpec入門・その1「RSpecの基本的な構文や便利な機能を理解する」](http://qiita.com/jnchito/items/42193d066bd61c740612)
* [RailsでAPI作成とAPIのテストのまとめ](http://ruby-rails.hatenadiary.com/entry/20150108/1420675366)
* [geokit-rails (Github)](https://github.com/geokit/geokit-rails)
* [RailsでAPIを作成するために色々比較したので所感と実装方法のご紹介](http://qiita.com/Kaki_Shoichi/items/d4adcf0298ed0b4614a2)
* [RSpecを使ってAPIのテストを行う](http://qiita.com/yu_0105/items/c7f09e7a92d22d27c312)
* [rspec-rails README](https://github.com/rspec/rspec-rails)
