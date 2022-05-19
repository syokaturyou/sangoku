RakutenWebService.configure do |c|
  # (必須) アプリケーションID
  c.application_id = ENV['RAKUTEN_APP_ID']
  # (任意) 楽天アフィリエイトID
  c.affiliate_id = ENV['RAKUTEN_AFFILIATE_ID']
end
