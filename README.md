utility
=======

フロントエンドスターターキット。
node.jsを事前にインストールすること。

## gulpをインストール

```
$ npm install -g gulp
$ mkdir project_name
$ cd project_name/
$ git clone https://github.com/yuhiisk/starter-kit.git ./
$ npm install
$ bower install
$ gulp
```

## Tasks
```
$ gulp # デフォルトタスク
$ gulp deploy # デプロイ（src/ を dist/ にコピー）
$ gulp minify (※工事中)
```

## Compassを使う

gulp/tasks/styles.coffee
`sass()` をコメントアウトして代わりに `$.compass()` を有効にする。
config.rbは別途用意すること。


## browserifyを使う

[browserify](http://browserify.org/)

gulpfile.coffee
`coffee` タスクを `browserify` に置き換えて使えます。

## CSSスプライトを使う

`src/assets/img/sprite/` にフォルダを分けて配置する。
フォルダごとに scss と スプライト画像が生成されます。

```
$ gulp sprite # 全てのスプライトを生成
$ gulp sprite-[フォルダ名] # フォルダ単位でスプライトを生成
```

生成されたscssはimportして使用する。
詳しくは `src/scss/module/sprite-map.scss` を参照。
