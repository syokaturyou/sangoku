crumb :root do #ページの名前
  link "トップページ", root_path #リンク名、リンク先ページ
end

crumb :postindex do #ページの名前
  link "投稿質問一覧", manager_posts_path #リンク名、リンク先ページ
end

crumb :postshow do
  link "投稿質問詳細", manager_post_path
  parent :postindex
end

crumb :memberindex do
  link "会員一覧", manager_members_path
  parent :root
end

crumb :membershow do
  link "会員詳細", manager_member_path
  parent :memberindex
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


# crumb :postnew do
#   link "新規質問投稿作成", new_public_post_path
#   parent :root
# end

# crumb :postedit do
#   link "投稿内容編集", edit_public_post_path
#   parent :root
# end

# crumb :answernew do
#   link "新規回答作成", new_public_post_answer_path
#   parent :root
# end

# crumb :answeredit do
#   link "回答編集", edit_public_answer_path
#   parent :postshow
# end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).