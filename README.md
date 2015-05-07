starter-kit
=======

フロントエンドスターターキット。  
node.jsを事前にインストールすること。

## インストール方法

### gulpをインストール
```
$ npm install -g gulp
```

### リポジトリをclone
```
$ mkdir project_name
$ cd project_name/
$ git clone https://github.com/yuhiisk/starter-kit.git ./
```

### npmモジュールをインストール
```
$ npm install
```

### タスクの実行
```
$ gulp
```

## Tasks
```
$ gulp # デフォルトタスク
$ gulp deploy # デプロイ（src/ を dist/ にコピー）
$ gulp minify (※工事中)
```

## Compassを使う

gulpfile.coffee
`styles` タスクの代わりに `compass` タスクを使用する。
`@import 'compass';` を忘れないこと。

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
