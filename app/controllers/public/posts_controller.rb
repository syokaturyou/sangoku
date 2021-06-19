class Public::PostsController < ApplicationController


  def index
    # 更新日時を降順に + 質問数が10より多かったら次ページに
    @posts = Post.all.order(updated_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    # 回答更新日時を降順に + 回答数が3より多かったら次ページに
    @answers = Answer.all.order(updated_at: "DESC").page(params[:page]).per(3)
    #レビュー一覧
    # @answer = Answer.find(params[:id])
    @rates = Rate.all

    @sum = 0
    @count = 0
    @rates.each do |rate|
    @sum += rate.communication
    @count += 1
    end

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
     redirect_to  public_posts_path
    else
     redirect_to root_path
    end
   end

  def destroy
    post = Post.find(params[:id])
    post.member_id = current_member.id
    post.destroy
    redirect_to action: :index
  end

  private
  def post_params
    params.require(:post).permit(:posttitle, :postbody, :postsyutten, :postimage_id)
  end

end
