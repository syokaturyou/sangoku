class ArticlesController < ApplicationController
  # トップページに表示するお知らせ用に作成 マークダウン形式使用
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
  end

  def show
    # 詳細画面は表示するだけ
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    # edit画面自体は表示するだけ
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
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
end
