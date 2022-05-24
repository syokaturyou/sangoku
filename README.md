# サイト名"我らの三国志"

## サイト概要

三国志に関する質問・回答・それに対するレビューを行えるサイトです！  
会員間の交流やおすすめ地域検索、書籍検索などの機能もございます。

### サイトテーマ
三国志ファンの会員制サイト

### テーマを選んだ理由
1.自分自身三国志ファンである  
2.最もpv数を稼ぐ三国志サイト含め、「出典の不確かな言論」「創作作品の設定」等が
　ネットの多くの空間でコピペの再生産のように増殖している状況です。  
3.「出典重視」の意見投稿プラットフォームを提供することで
　上記状況に不満を持つ層の受け皿となれると考えました。  
4.長期的に三国志界の健全な発展を図れるサイトを目指します。

### ターゲットユーザ
三国志ファン全般  
※「三国志」と名付ければ集客しやすいため、まずは三国志ファン向けとしておりますが  
　内容的には日本の戦国時代等他テーマの設定も可能です。

### 主な利用シーン
1.質問・意見投稿、それに対する(出典付きの)回答、回答に対する評価  
※ポジティブ・建設的意見を推奨するためgoogle APIによる自然言語処理も導入し、
  感情判定スコアが一定数に満たないものは回答を見れないようにしております。  
2.おすすめ地域探索・評価

## 動画(基本機能確認)
<https://user-images.githubusercontent.com/78064150/169672109-a775960e-932c-4d20-9731-d267ebfedb0c.mp4>

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

# 主な機能

・deviseログイン(ゲストログイン含む)  
・googleアカウント,twitterアカウント等、Omniauth連携によるSNS認証を用いたログイン  
・質問、回答に対する,CRUD処理機能  
・GoogleCLoudAPI使用(自然言語処理、画像認識、map取得)  
・twitterAPIを用いたトレンド取得、投稿に対するbot作成  
・rakutenAPIを用いた書籍検索  
・いいね機能、評価・レビュー機能    
・全体雑談、会員間チャット機能  
・お問い合わせ(Action mailer)機能  
・検索(質問、会員、ジャンル)  

 チャレンジ機能詳細    
<https://docs.google.com/spreadsheets/d/1zPWbBf5LPooUiv881fnYykwafSUyzLCTWYFeSWpYjNs/edit#gid=0>

## 設計書
AWS使用構成図  
![3594-AWS使用構成図 drawio](https://user-images.githubusercontent.com/78064150/169643132-1840787c-badf-47c2-a610-2c42eacf4134.png)  
テーブル定義  
![3594-テーブル定義書 drawio](https://user-images.githubusercontent.com/78064150/169643091-e8b98c47-2331-43a7-bbef-85cbaf8089c2.png)  
ER図  
![3594-ER図 drawio](https://user-images.githubusercontent.com/78064150/169643157-1c43efd0-9907-4ed7-8188-1a5ad6983baa.png)  
アプリケーション詳細設計  
![3594-アプリケーション詳細設計 drawio (1)](https://user-images.githubusercontent.com/78064150/169950696-898c3cb2-787d-45cc-bdbc-dfa8718c2d03.png)

