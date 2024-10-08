# インストール

以下の手順でメモアプリをローカル環境にインストールします。

1. ターミナルを開き、任意のディレクトリに移動します。
2. 次のコマンドでリポジトリをクローンします。

```bash
git clone https://github.com/misonabema/sinatra.git
```

3. クローンしたリポジトリに移動します。

```bash
cd sinatra
```

# 使い方

1. Gemfileに記述されているGemをインストールします。

```bash
bundle install
```

2. 次のコマンドを実行します。

```bash
ruby memo.rb
```

3. ブラウザで http://localhost:4567/ にアクセスすると、メモアプリが動作します。
