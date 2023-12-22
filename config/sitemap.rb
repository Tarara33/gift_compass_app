# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://gift-compass.com"

SitemapGenerator::Sitemap.create do
  # 静的ページ
  add privacy_policy_path, changefreq: 'yearly'
  add terms_of_service_path, changefreq: 'yearly'

  # ユーザー登録ページ
  add new_user_path, changefreq: 'monthly'

  # ログインページ
  add login_path, priority: 0.7, changefreq: 'monthly'

  # パスワードリセットページ
  add new_password_reset_path, changefreq: 'monthly'

  # アイテム一覧ページ
  add items_path, priority: 0.7, changefreq: 'daily'
end
