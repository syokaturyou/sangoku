module Manager
  class PostsController < ApplicationController
    before_action :authenticate_admin!
    # 管理者側では一覧・詳細画面と質問削除が可能
    def index
      # デフォルトは更新日時の降順に並べる
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
        @posts = Post.joins(:answers).order('count(answers.member_id) desc').group('answers.post_id').page(params[:page]).per(10)
      when '回答数の少ない順に'
        @posts = Post.joins(:answers).order('count(answers.member_id) asc').group('answers.post_id').page(params[:page]).per(10)
      when '未回答だけ'
        @posts = Post.recent.page(params[:page]).per(10)
      end
    end

    def show
      @post = Post.find(params[:id])
      # impressionist(@post, nil) # show画面閲覧時にカウント
      @answers = @post.answers.order(updated_at: 'DESC').page(params[:page]).per(2) # 回答一覧表示+ページネーション用
    end

    def download
      # ダウンロードボタン押下時処理
      @post = Post.find(params[:id])
      @answers = @post.answers
      # ファイル作成・ダウンロード処理 回答がなければ質問内容だけ出力させる
      filedata = "質問タイトル: " + @post.posttitle + "\n質問者: " + @post.member.name + "\n出典・参考URL: " + @post.postsyutten + "\n質問本文: " + @post.postbody +  "\n"
      if @answers.count > 0
        @answers.each do |answer, i|
          i = "\n回答者: " + answer.member.name + "\n出典・参考URL: " + answer.answersyutten + "\n回答本文: " + answer.answerbody + "\n"
          filedata.concat(i)
        end
      end
      filename = "#{@post.posttitle}.txt"
      filename = ERB::Util.url_encode(filename) if /MSIE/ =~ request.user_agent
      send_data(filedata, :filename => filename, :type => 'text/plain')
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      flash[:notice] = '質問を削除しました'
      redirect_to action: :index
    end

    private

    def post_params
      params.require(:post).permit(:posttitle, :postbody, :postsyutten, :postimage)
    end
  end
end
