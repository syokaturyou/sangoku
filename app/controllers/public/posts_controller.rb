class Public::PostsController < ApplicationController
  def index
    # 更新日時を降順に + 質問数が10より多かったら次ページに
    @posts = Post.all.order(updated_at: "DESC").page(params[:page]).per(10)
    @answer = Answer.all # 回答数カウントに使用
  end

  def show
    @post = Post.find(params[:id])
    # 回答更新日時を降順に + 回答数が3より多かったら次ページに
    @answers = Answer.all.order(updated_at: "DESC").page(params[:page]).per(3)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @newpost = Post.new
  end

  def create
    @newpost = current_member.posts.build(post_params)
     if @newpost.save
     redirect_to  public_posts_path
     else
     redirect_to root_path
     end
  end

   def update
      @post = Post.find(params[:id])
    if @post.update(post_params)
      if params[:image_delete].present? # 画像なしの場合に既存画像削除
        @post.update(postimage: nil)
      end
     redirect_to  public_posts_path
    else
     redirect_to root_path
    end
   end

  def destroy
    post = Post.find(params[:id])
    post.member_id = current_member.id # ログイン者自身の投稿のみ削除可能
    post.destroy
    redirect_to action: :index
  end

  private
  def post_params
    params.require(:post).permit(:posttitle, :postbody, :postsyutten, :postimage, :genre_id)
  end

end
