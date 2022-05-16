class ZatudansController < ApplicationController
  # 雑談部屋。非ログイン状態で可能

  def index
    @newzatudan = Zatudan.new
    @zatudans = Zatudan.all.order(updated_at: 'DESC').page(params[:page]).per(20)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET_TOKEN"]
    end
    @trends = client.trends(id = 23424856).attrs[:trends].first(20)
  end

  def create
    @zatudan = Zatudan.new(zatudan_params)
    @zatudan.save
    redirect_to zatudans_path
  end

  private

  def zatudan_params
    params.require(:zatudan).permit(:message)
  end
end
