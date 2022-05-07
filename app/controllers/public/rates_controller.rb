module Public
  class RatesController < ApplicationController
    before_action :authenticate_member!
    # Rateモデルはレビュー機能に関して使用
    def new
      @newrate = Rate.new
    end

    def create
      @newrate = Rate.new(rate_params)
      @newrate.member = current_member
      # 以下4行は評価点0だった場合も数えるために使用
      @newrate.communication = @newrate.communication || 0
      @newrate.source = @newrate.source || 0
      @newrate.rationality = @newrate.rationality || 0
      @newrate.intellect = @newrate.intellect || 0
      rate_count = Rate.where(answer_id: params[:answer_id]).where(member_id: current_member.id).count
      # 各会員は1回答に1回だけレビュー可能であるため条件分岐
      if rate_count < 1
        @newrate.save
        flash[:notice] = '評価を投稿しました'
        redirect_to public_post_path(@newrate.answer.post_id)
      else
        flash[:notice] = '一度評価を投稿したため再度投稿できません'
        redirect_to public_posts_path
      end
    end

    private

    def rate_params
      params.require(:rate).permit(:communication, :source, :rationality, :intellect, :answer_id, :post_id, :member_id)
    end
  end
end
