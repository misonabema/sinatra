# 必要条件
- Ruby 3.x
- PostgreSQL

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

2. `sinatra_memo`というデータベースを作成します。

```bash
createdb sinatra_memo
```

3. `sinatra_memo`のコンソールを開きます。

```bash
psql sinatra_memo
```

4. 以下のSQLを実行して`memos`テーブルを作成します。

```bash
CREATE TABLE memos (
  id SERIAL PRIMARY KEY,
  uuid VARCHAR(36) NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

5. 次のコマンドを実行します。

```bash
ruby memo.rb
```

6. ブラウザで http://localhost:4567/ にアクセスすると、メモアプリが動作します。
