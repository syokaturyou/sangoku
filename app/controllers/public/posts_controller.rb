class Public::PostsController < ApplicationController

  def index
    # デフォルトは更新日時の降順に並べる
    @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    @range = params[:range] # 並べ替え選択時のページネーションを場合分け
    case @range
    when "投稿Noが新しい順に"
      @posts = Post.all.order(id: 'DESC').page(params[:page]).per(10)
    when "投稿Noが古い順に"
      @posts = Post.all.order(id: 'ASC').page(params[:page]).per(10)
    when "更新日時が新しい順に"
      @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    when "更新日時が古い順に"
      @posts = Post.all.order(updated_at: 'ASC').page(params[:page]).per(10)
    when "ジャンルidが大きい順に"
      @posts = Post.all.order(genre_id: 'DESC').page(params[:page]).per(10)
    when "ジャンルidが小さい順に"
      @posts = Post.all.order(genre_id: 'ASC').page(params[:page]).per(10)
    when "質問者idが大きい順に"
      @posts = Post.all.order(member_id: 'DESC').page(params[:page]).per(10)
    when "質問者idが小さい順に"
      @posts = Post.all.order(member_id: 'ASC').page(params[:page]).per(10)
    when "PV数の多い順に"
      @posts = Post.all.order(impressions_count: 'DESC').page(params[:page]).per(10)
    when "PV数の少ない順に"
      @posts = Post.all.order(impressions_count: 'ASC').page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil) # show画面閲覧時にカウントさせる
    # 現ログインユーザーが一回既に回答してたらそれ以上回答できなくする
    @answer = Answer.find_by(post_id: params[:id], member_id: current_member.id) if member_signed_in? # 非ログイン時にエラーとなるため
    @answers = @post.answers.order(updated_at: 'DESC').page(params[:page]).per(2) # 回答一覧表示+ページネーション用
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @newpost = Post.new
  end

  def create
    @newpost = current_member.posts.build(post_params)
    @newpost.score = Language.get_data(post_params[:postbody])  # 感情スコア取得
     if @newpost.save
     redirect_to  public_posts_path
     else
     redirect_to root_path
     end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @post.score = Language.get_data(post_params[:postbody]) # 更新されれば感情スコアも更新されるよう実施
    @post.save
    @post.update(postimage: nil) if params[:image_delete].present? # 「画像なし」を選択した場合postimageをnilにする
    redirect_to  public_posts_path
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
