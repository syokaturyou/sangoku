module Public
  class PostsController < ApplicationController
    before_action :twitter_client, only: [:create, :update]
    def index
      # デフォルトは更新日時の降順に並べるよ
      @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
      @range = params[:range] # 並べ替え選択時のページネーションを場合分け
      case @range
      when '投稿Noが新しい順に'
        @posts = Post.all.order(id: 'DESC').page(params[:page]).per(10)
      when '投稿Noが古い順に'
        @posts = Post.all.order(id: 'ASC').page(params[:page]).per(10)
      when '更新日時が新しい順に'
        @posts = Post.all.order(updated_at: 'DESC').page(params[:page]).per(10)
      when '更新日時が古い順に'
        @posts = Post.all.order(updated_at: 'ASC').page(params[:page]).per(10)
      when 'ジャンルidが大きい順に'
        @posts = Post.all.order(genre_id: 'DESC').page(params[:page]).per(10)
      when 'ジャンルidが小さい順に'
        @posts = Post.all.order(genre_id: 'ASC').page(params[:page]).per(10)
      when 'PV数の多い順に'
        @posts = Post.all.order(impressions_count: 'DESC').page(params[:page]).per(10)
      when 'PV数の少ない順に'
        @posts = Post.all.order(impressions_count: 'ASC').page(params[:page]).per(10)
      when '回答数の多い順に'
        @posts = Post.joins(:answers).order('count(answers.member_id) desc').group(:post_id).page(params[:page]).per(10)
      when '回答数の少ない順に'
        @posts = Post.joins(:answers).order('count(answers.member_id) asc').group(:post_id).page(params[:page]).per(10)
      when '未回答だけ'
        @posts = Post.recent.page(params[:page]).per(10)
      end
    end

    def show
      @post = Post.find(params[:id])
      # impressionist(@post, nil) # show画面閲覧時にカウントさせる
      # 現ログインユーザーが一回既に回答してたらそれ以上回答できなくする
      @answer = Answer.find_by(post_id: params[:id], member_id: current_member.id) if member_signed_in? # 非ログイン時にエラーとなるため
      @answers = @post.answers.order(updated_at: 'DESC').page(params[:page]).per(2) # 回答一覧表示+ページネーション用
    end

    def edit
      @post = Post.find(params[:id])
      # 作成したユーザーのみ編集可能
      return if @post.member == current_member

      redirect_to new_public_post_path
    end

    def new
      @newpost = Post.new
    end

    def create
      @newpost = current_member.posts.build(post_params)
      @newpost.score = Language.get_data(post_params[:postbody]) # 感情スコア取得
      if @newpost.save
        flash[:notice] = '質問を投稿しました'
        # 新規投稿時にツイッターbotを動かす
        @client.update("新規質問が投稿されました。\n\n#{@newpost.posttitle} \nwarerano3594.com/public/posts/#{@newpost.id}\r\
        \n\n回答をお待ちしております\r\n\n#我らの三国志 #三国志 ##{@newpost.genre.name} ")
        redirect_to public_posts_path
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
      # 質問更新時にもツイッターbotを動かす
      @client.update("質問が更新されました。\n\n#{@post.posttitle}\nwarerano3594.com/public/posts/#{@post.id}\r\
      \n\n回答をお待ちしております\r\n\n#我らの三国志 #三国志 ##{@post.genre.name} ")
      flash[:notice] = '質問を更新しました'
      redirect_to public_posts_path
    end

    def destroy
      post = Post.find(params[:id])
      post.member_id = current_member.id # ログイン者自身の投稿のみ削除可能
      post.destroy
      flash[:notice] = '質問を削除しました'
      redirect_to action: :index
    end

    private

    def post_params
      params.require(:post).permit(:posttitle, :postbody, :postsyutten, :postimage, :genre_id)
    end

    def twitter_client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_KEY']
        config.consumer_secret     = ENV['TWITTER_API_SECRET_KEY']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_SECRET_TOKEN']
      end
    end
  end
end
