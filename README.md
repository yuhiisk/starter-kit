utility
=======

フロントエンドスターターキット。
node.jsを事前にインストールすること。

## gulpをインストール

```
$ npm install -g gulp
$ mkdir project_name
$ cd project_name/
$ npm install
$ bower i
$ gulp
```

## Compassを使う

gulp/tasks/styles.coffee
`sass()` をコメントアウトして代わりに `$.compass()` を有効にする。
config.rbは別途用意すること。


## browserifyを使う

[browserify](http://browserify.org/)

gulpfile.coffee
`coffee` タスクを `browserify` に置き換えて使えます。

# Tasks
```
$ gulp # デフォルトタスク
$ gulp deploy # デプロイ（src/ を dist/ にコピー）
$ gulp minify (※工事中)
```
