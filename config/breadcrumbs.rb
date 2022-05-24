crumb :root do
  link 'トップページ', root_path
end

crumb :publicmemberindex do
  link '会員一覧', public_members_path
  parent :root
end

crumb :publicmembershow do
  link '会員詳細', public_member_path
  parent :publicmemberindex
end

crumb :publicmemberedit do
  link '会員情報編集', edit_public_member_path
  parent :publicmembershow
end

crumb :publicmemberunsubscribe do
  link '会員退会', public_unsubscribe_path
  parent :publicmemberindex
end

crumb :publicchat do
  link '会員チャット', public_chat_path
  parent :publicmembershow
end

crumb :managermemberindex do
  link '会員一覧', manager_members_path
  parent :root
end

crumb :managermembershow do
  link '会員詳細', manager_member_path
  parent :managermemberindex
end

crumb :managermemberedit do
  link '会員情報編集', edit_manager_member_path
  parent :managermembershow
end

crumb :publicpostindex do
  link '質問投稿一覧', public_posts_path
  parent :root
end

crumb :publicpostshow do
  link '投稿質問詳細', public_post_path
  parent :publicpostindex
end

crumb :publicpostnew do
  link '投稿質問新規作成', new_public_post_path
  parent :publicpostindex
end

crumb :publicanswernew do
  link '新規回答作成', new_public_post_answer_path
  parent :publicpostindex
end

crumb :publicansweredit do
  link '回答内容編集', edit_public_answer_path
  parent :publicpostindex
end

crumb :publicanswerrate do
  link '評価投稿', new_public_answer_rate_path
  parent :publicpostindex
end

crumb :publicpostedit do
  link '投稿質問編集', edit_public_post_path
  parent :publicpostshow
end

crumb :managerpostindex do
  link '質問投稿一覧', manager_posts_path
  parent :root
end

crumb :managerpostshow do
  link '投稿質問詳細', manager_post_path
  parent :managerpostindex
end

crumb :managergenresindex do
  link 'ジャンル一覧', manager_genres_path
  parent :root
end

crumb :managergenresedit do
  link 'ジャンル編集', edit_manager_genre_path
  parent :managergenresindex
end

crumb :articleindex do
  link 'お知らせ一覧', articles_path
  parent :root
end

crumb :articleedit do
  link 'お知らせ編集', edit_article_path
  parent :articleindex
end

crumb :articlenew do
  link 'お知らせ新規作成', new_article_path
  parent :articleindex
end

crumb :result do
  link '検索結果', search_result_path
  parent :publicpostindex
end

crumb :newsight do
  link 'おすすめ地域探索', new_sight_path
  parent :sightindex
end

crumb :sightindex do
  link 'おすすめ地域一覧', sights_path
  parent :root
end

crumb :sightedit do
  link 'おすすめ地域編集', edit_sight_path
  parent :sightshow
end

crumb :sightshow do
  link 'おすすめ地域詳細', sight_path
  parent :sightindex
end

crumb :newevaluate do
  link 'おすすめ地域評価投稿', new_sight_evaluate_path
  parent :sightindex
end

crumb :booksearch do
  link '書籍検索', book_search_path
  parent :root
end

crumb :tweetsearch do
  link 'ツイート検索', tweets_search_path
  parent :root
end

