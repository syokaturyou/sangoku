class LikesController < ApplicationController
  def create
    @sight_like = Like.new(member_id: current_member.id, sight_id: params[:sight_id])
    @sight_like.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @sight_like = Like.find_by(member_id: current_member.id, sight_id: params[:sight_id])
    @sight_like.destroy
    redirect_back fallback_location: root_path
  end
end
