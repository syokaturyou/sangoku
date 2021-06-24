class SearchsController < ApplicationController
  # 検索機能で使用。検索結果はsearchs/result画面に表示
  def search
    @range = params[:range]
    case @range
    when "会員"
      @members = Member.looks(params[:search], params[:word]).page(params[:page]).per(10)
      @oomember = params[:word]
      render 'result'
    when "ジャンル"
      @genres = Genre.looks(params[:search], params[:word]).page(params[:page]).per(10)
      # ジャンル検索時にpostの情報も使用するため以下行使用
      @posts = Post.all.page(params[:page]).per(10).order(updated_at: "DESC").page(params[:page]).per(10)
      @oogenre = params[:word]
      render 'result'
    else
      # 質問タイトルで検索時
      @posts = Post.looks(params[:search], params[:word]).order(updated_at: "DESC").page(params[:page]).per(10)
      @oopost = params[:word]
      render 'result'
    end
  end
end
