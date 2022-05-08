class EvaluatesController < ApplicationController
  before_action :authenticate_member!
    # Evaluateモデルはレビュー機能に関して使用
    def new
      @newevaluate = Evaluate.new
    end

    def create
      @newevaluate = Evaluate.new(evaluate_params)
      @newevaluate.member = current_member
      # 以下は評価点0だった場合も数えるために使用
      @newevaluate.rate = @newevaluate.rate || 0
      evaluate_count = Evaluate.where(sight_id: params[:sight_id]).where(member_id: current_member.id).count
      # 各会員は1マップに1回だけレビュー可能であるため条件分岐
      if evaluate_count < 1
        @newevaluate.save
        flash[:notice] = '評価を投稿しました'
        redirect_to sights_path(@newevaluate.sight.id)
      else
        flash[:notice] = '一度評価を投稿したため再度投稿できません'
        redirect_to sights_path
      end
    end

    private

    def evaluate_params
      params.require(:evaluate).permit(:sight_id, :rate, :member_id)
    end
end
