class SearchsController < ApplicationController
  def search
    @range = params[:range]
    case @range
    when :"会員"
      @members = Member.looks(params[:search], params[:word]).page(params[:page]).per(10)
      @oomember = params[:word]
      render 'result'
    when :"ジャンル"
      @genres = Genre.looks(params[:search], params[:word]).page(params[:page]).per(10)
      @oogenre = params[:word]
      render 'result'
    else
      @posts = Post.looks(params[:search], params[:word]).order(updated_at: "DESC").page(params[:page]).per(10)
      @oopost = params[:word]
      render 'result'
    end
  end
end
