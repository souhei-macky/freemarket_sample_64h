crumb :root do
  link "メルカリ", root_path
end

# Gemのgretelが何をしているかを記載しておきます。
# ・ :mypages ← 設定ファイルを呼び出します。
# ・ "マイページ" ← パンくずリストに表示される名称です。
# ・ mypage_path ← 呼び出し元のパスを指定します。（rails routesでパスを確認しましょう）
# マイページ
crumb :mypages do
  link "マイページ", mypage_path(current_user)
end

# config/breadcrumb.rbのcrumbとendの間に
# parentを設定することで親を設定することができます。
# プロフィール
crumb :profile do
  link "プロフィール", profile_mypages_path
  parent :mypages
end

# 支払い方法（クレジットカード）
crumb :credit do
  link "支払い方法", credit_mypages_path
  parent :mypages
end

# 本人情報
crumb :identification do
  link "本人情報", identification_mypages_path
  parent :mypages
end

# ログアウト
crumb :logout do
  link "ログアウト", logout_mypages_path
  parent :mypages
end

# 出品リスト
crumb :list do
  link "出品リスト", logout_mypages_path
  parent :mypages
end
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