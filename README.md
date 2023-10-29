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