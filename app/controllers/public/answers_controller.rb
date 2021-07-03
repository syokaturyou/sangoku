class Public::AnswersController < ApplicationController
  #会員側で新規回答投稿、回答削除、回答編集が可能
  def new
    @newanswer = Answer.new
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.member_id = current_member.id
    answer.destroy
    redirect_back(fallback_location: root_path)
  end

  def create
    @newanswer = Answer.new(answer_params)
    @newanswer.member = current_member
    @newanswer.score = Language.get_data(answer_params[:answerbody])  #この行を追加
     if @newanswer.save
       #回答が作成されれば質問の更新日時を更新
        @newanswer.post.update({updated_at: @newanswer.updated_at})
       #回答が作成されればタグ付け
        tags = Vision.get_image_data(@newanswer.answerimage)
        tags.each do |tag|
         @newanswer.tags.create(name: tag)
        end

        redirect_to public_post_path(@newanswer.post_id)
     else
        redirect_to root_path
     end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
     @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      #回答更新されれば感情スコアも更新されるよう実施
      #@answer.score = Language.get_data(answer_params[:answerbody])
      #回答が更新されれば質問の更新日時を更新
       @answer.post.update({updated_at: @answer.updated_at})
       redirect_to  public_post_path(@answer.post_id)
    else
       redirect_to root_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answerbody, :answersyutten, :answerimage, :post_id, :updated_at)
  end

end
