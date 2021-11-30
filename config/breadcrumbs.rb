crumb :root do
  link "トップページ", root_path
end

crumb :managermemberindex do
  link "会員一覧", manager_members_path
  parent :root
end

crumb :managermembershow do
  link "会員詳細", manager_member_path
  parent :managermemberindex
end

crumb :managermemberedit do
  link "会員情報編集", edit_manager_member_path
  parent :managermembershow
end

crumb :articleindex do
  link "お知らせ一覧", articles_path
  parent :root
end

crumb :articleedit do
  link "お知らせ編集", edit_article_path
  parent :articleindex
end

crumb :articlenew do
  link "お知らせ新規作成", new_article_path
  parent :articleindex
end