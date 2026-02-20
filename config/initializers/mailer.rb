# メール送信設定 (SMTP)
# 本番環境では以下の環境変数を設定してください:
#   SMTP_HOST         : SMTPサーバーのホスト名
#   SMTP_PORT         : SMTPポート (例: 587)
#   SMTP_USERNAME     : SMTPユーザー名
#   SMTP_PASSWORD     : SMTPパスワード
#   MAILER_FROM       : 送信元メールアドレス
#   APP_HOST          : アプリケーションのホスト名

if Rails.env.production?
  SampleApp::Application.config.action_mailer.delivery_method = :smtp
  SampleApp::Application.config.action_mailer.smtp_settings = {
    address:              ENV.fetch('SMTP_HOST', 'smtp.gmail.com'),
    port:                 ENV.fetch('SMTP_PORT', 587).to_i,
    domain:               ENV.fetch('APP_HOST', 'example.com'),
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       :plain,
    enable_starttls_auto: true
  }
  SampleApp::Application.config.action_mailer.default_url_options = {
    host: ENV.fetch('APP_HOST', 'example.com')
  }
end

if Rails.env.development?
  SampleApp::Application.config.action_mailer.delivery_method = :smtp
  SampleApp::Application.config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_HOST', 'localhost'),
    port:    ENV.fetch('SMTP_PORT', 1025).to_i
  }
  SampleApp::Application.config.action_mailer.default_url_options = {
    host: 'localhost:3000'
  }
end
