class Public::RatesController < ApplicationController
  def new
    @newrate = Rate.new
  end
  def show
    @answer = Answer.find(params[:id])
    @rates = Rate.all
    # @rate = Rate.find(params[:id])
    # @rate = Rate.find(3)
  end
  def create
    @newrate = Rate.new(rate_params)
    @newrate.member = current_member
    @newrate.communication = @newrate.communication || 0
    @newrate.source = @newrate.source || 0
    @newrate.rationality = @newrate.rationality || 0
    @newrate.intellect = @newrate.intellect || 0
    if @newrate.save
      redirect_to root_path
    else
      redirect_to public_posts_path
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:communication, :source, :rationality, :intellect, :answer_id, :post_id, :member_id)
  end

end
