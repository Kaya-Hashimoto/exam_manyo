# README

### テーブルスキーマ

モデル **task**
* string:title
* text:content
---
以下実装予定

モデル **User**
* string:name
* string:email
* string:password_digest
* int:task_id FK

モデル **Label**
* string:title

モデル **Labeling**
* int:task_id FK
* int:labels_id FK

---
herokuへのデプロイ手順

```
heroku login
heroku create
git init
git add .
git commit -m "herokuデプロイ準備"
git push heroku step2:master
heroku addons:create heroku-postgresql
heroku run rails db:migrate
```
