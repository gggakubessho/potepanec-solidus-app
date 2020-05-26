# 概要
OSSのECサイトパッケージであるSolidusを用いたECサイト

プログラミングスクール(ポテパン)の課題となり、

現役エンジニア陣によるコードレビューを受け実装

# 実装機能
- トップページ
https://potepanec-20200525232431.herokuapp.com/potepan
- 商品詳細ページ
https://potepanec-20200525232431.herokuapp.com/potepan
- 商品カテゴリページ
https://potepanec-20200525232431.herokuapp.com/potepan/products/1
- サジェスト機能用API
curl -H 'Authorization: Bearer {api_key}' 'https://potepanec-20200525232431.herokuapp.com/potepan/api/suggests?keyword=ruby&max_num=5'


# 機能詳細
- トップページ
・ヘッダー、フッター、タイトルの実装

- 商品詳細ページ
・商品詳細の表示
・関連商品の表示

- 商品カテゴリページ
・サイドメニューカテゴリ一覧の表示
・特定カテゴリの商品一覧の表示

- サジェスト機能用API
・認証機能
・keywordパラメータにマッチしたデータを返却
・エラーハンドリング

# 使用技術
- ruby 2.5.1
- Ruby on Rails 5.2.1
- mysql 8.0
- RSpec
- RuboCop
- AWS S3
画像管理
- docker
開発環境構築
- heroku
本番環境デプロイ
- CircleCI
RSpec,RuboCop,デプロイの自動実行

