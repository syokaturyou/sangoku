class SearchsController < ApplicationController
  before_action :authenticate_member!

 def search
    @range = params[:range]

    if @range == "会員"
      @members = Member.looks(params[:search], params[:word])
      @oomember = params[:word]
      render 'result'
    else
      @posts = Post.looks(params[:search], params[:word])
      @oopost = params[:word]
      render 'result'
    end
 end
end
