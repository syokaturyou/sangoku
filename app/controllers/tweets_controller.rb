class TweetsController < ApplicationController
  # 2023 2/7 廃止
  # def search
  #   client = Twitter::REST::Client.new do |config|
  #     # 事前準備で取得したキーのセット
  #     config.consumer_key        = ENV['TWITTER_API_KEY']
  #     config.consumer_secret     = ENV['TWITTER_API_SECRET_KEY']
  #     config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  #     config.access_token_secret = ENV['TWITTER_ACCESS_SECRET_TOKEN']
  #   end
  #   @trends = client.trends(234_248_56).attrs[:trends].first(10)
  #   since_id = nil
  #   # 検索ワードが存在していたらツイートを取得
  #   if params[:keyword].present?
  #     # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
  #     @tweets = client.search(params[:keyword], count: 10, result_type: 'recent', exclude: 'retweets', since_id: since_id)
  #   end
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
  #   end
  # end
end
