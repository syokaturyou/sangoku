class Manager::AnswersController < ApplicationController
  # 管理者側では回答削除のみ
  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    flash[:notice] = '回答を削除しました'
    redirect_back(fallback_location: root_path)
  end

end
