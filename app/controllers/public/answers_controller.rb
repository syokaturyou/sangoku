module Public
  class AnswersController < ApplicationController
    before_action :authenticate_member!
    before_action :twitter_client, only: [:create, :update]
    # 会員側では新規回答投稿、回答編集、回答削除が可能
    def new
      @newanswer = Answer.new
    end

    def destroy
      answer = Answer.find(params[:id])
      answer.member_id = current_member.id
      answer.destroy
      flash[:notice] = '回答を削除しました'
      redirect_back(fallback_location: root_path)
    end

    def create
      @newanswer = Answer.new(answer_params)
      @newanswer.member = current_member
      @newanswer.score = Language.get_data(answer_params[:answerbody]) # 感情スコア取得
      if @newanswer.save
        @newanswer.post.update({updated_at: @newanswer.updated_at}) # 回答が作成されれば質問の更新日時を更新
        if @newanswer.answerimage.present? # 画像投稿しないときにget_image_dataに行かないようにさせる
          tags = Vision.get_image_data(@newanswer.answerimage) # 回答が作成されればタグ付けさせる
          tags.each do |tag|
            @newanswer.tags.create(name: tag)
          end
        end
        flash[:notice] = '回答を投稿しました'
        # 新規回答時にツイッターbotを動かす
        @client.update("回答が入ってました。\n\n#{@newanswer.post.posttitle}\nwarerano3594.com/public/posts/#{@newanswer.post_id}\r\
        \n\n#我らの三国志 #三国志 ##{@newanswer.post.genre.name} ")
        redirect_to public_post_path(@newanswer.post_id)
      else
        redirect_to root_path
      end
    end

    def edit
      @answer = Answer.find(params[:id])
      # 作成したユーザーのみ編集可能
      return if @answer.member == current_member
      redirect_to public_posts_path
    end

    def update
      @answer = Answer.find(params[:id])
      if @answer.update(answer_params)
        if params[:image_delete].present?
          @answer.update(answerimage: nil)
          @answer.tags.delete_all # 画像なしの場合にタグ消去
        end
        @answer.score = Language.get_data(answer_params[:answerbody]) # 回答更新されれば感情スコアも更新されるよう実施
        @answer.save
        @answer.post.update({updated_at: @answer.updated_at}) # 回答が更新されれば質問の更新日時を更新
        if @answer.answerimage.present? # 画像投稿しない場合にvision_getが走らないようにするための条件
          tags = Vision.get_image_data(@answer.answerimage)
          @answer.tags.delete_all # 画像なしの場合にタグ消去
          tags.each do |tag|
            @answer.tags.create(name: tag)
          end
        end
        flash[:notice] = '回答を更新しました'
        # 回答更新時にもツイッターbotを動作させる
        @client.update("回答が更新されました\n\n#{@answer.post.posttitle}\nwarerano3594.com/public/posts/#{@answer.post_id}\r\
        \n\n#我らの三国志 #三国志 ##{@answer.post.genre.name}")
        redirect_to public_post_path(@answer.post_id)
      else
        redirect_to root_path
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:answerbody, :answersyutten, :answerimage, :post_id, :updated_at)
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
