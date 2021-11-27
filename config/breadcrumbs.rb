# crumb :root do
#   link "トップページ", root_path
# end

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

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).