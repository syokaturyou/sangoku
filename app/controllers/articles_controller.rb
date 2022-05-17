class ArticlesController < ApplicationController
  # トップページに表示するお知らせ用に作成 マークダウン形式使用
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :twitter_client, only: [:create]

  def index
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET_KEY']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET_TOKEN']
    end
    # 日本のトレンドを取得
    @trends = client.trends(234_248_56).attrs[:trends].first(10)
    # @tweets = client.user_timeline(user_id: id, result_type: "recent", locale: "ja").first(10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
        # お知らせ作成時にtwitterbot作成
        @client.update("お知らせを作成しました。\n \n #{@article.title} \n #{article_url(@article.id)}\r")
        flash[:notice] = 'お知らせを新規作成しました'
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
        flash[:notice] = 'お知らせを更新しました'
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
    flash[:notice] = 'お知らせを削除しました'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET_KEY']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET_TOKEN']
    end
  end
end
