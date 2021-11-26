class Manager::AnswersController < ApplicationController
  # 管理者側では回答削除のみ
  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_back(fallback_location: root_path)
  end

end
