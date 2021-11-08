class Manager::PostsController < ApplicationController
  # 管理者側では一覧・詳細画面と質問削除が可能
  def index
    # 更新日時を降順に + 質問数が10より多かったら次ページに
    @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    @answer = Answer.all # 回答数カウントに使用
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  private

  def post_params
    params.require(:post).permit(:posttile, :postbody, :postsyutten, :postimage)
  end
end
