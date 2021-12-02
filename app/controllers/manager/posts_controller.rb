class Manager::PostsController < ApplicationController

  impressionist actions: [:show] # showアクションで閲覧数確認のため追加

  # 管理者側では一覧・詳細画面と質問削除が可能
  def index
    # 更新日時を降順に + 質問数が10より多かったら次ページに
    @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    @answer = Answer.all # 回答数カウントに使用
    @range = params[:range] # 並べ替え選択時のページネーションを場合分け
    case @ranges
    when "更新日時が新しい順に"
      @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    when "投稿Noが新しい順に"
      @posts = Post.all.order(id: 'DESC').page(params[:page]).per(10)
    when "投稿Noが古い順に"
      @posts = Post.all.order(id: 'ASC').page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:session_hash.to_s]) # HP閲覧数を表示 to_sメソッドはSessionIdエラー防止のため追加
    @answers = @post.answers.order(updated_at: 'DESC').page(params[:page]).per(2) # 回答一覧表示+ページネーション用
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  private

  def post_params
    params.require(:post).permit(:posttitle, :postbody, :postsyutten, :postimage)
  end
end
