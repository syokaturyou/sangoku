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
      genre_ids = Genre.looks(params[:search], params[:word]).ids
      # genreの検索内容を含むpostを表示させる処理
      @posts = Post.where(genre_id: genre_ids).order(updated_at: "DESC").page(params[:page]).per(10)
      @oogenre = params[:word]
      render 'result'
    when "質問タイトル" # 質問タイトルで検索時
      @posts = Post.looks(params[:search], params[:word]).order(updated_at: "DESC").page(params[:page]).per(10)
      @oopost = params[:word]
      render 'result'
    when "更新日時が新しい順に"
    @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    render 'result'
    when "投稿Noが新しい順に"
    @posts = Post.all.order(id: 'DESC').page(params[:page]).per(10)
    render 'result'
    else #"投稿Noが古い順に"
    @posts = Post.all.order(id: 'ASC').page(params[:page]).per(10)
    render 'result'
    end
  end
end
