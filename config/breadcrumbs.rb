crumb :root do
  link "会員一覧", manager_members_path
end

crumb :managermenbershow do
  link "会員詳細", manager_member_path
  parent :root
end

crumb :managermenberedit do
  link "会員情報編集", edit_manager_member_path
  parent :managermenbershow
end