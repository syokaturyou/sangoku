class SightsController < ApplicationController
  def new
    @newsight = Sight.new
  end

  def index
    @sights = Sight.all
  end

  def create
    @newsight = Sight.new(sight_params)
    # @newmap = current_member.maps.build(map_params)
    if @newsight.save
      flash[:notice] = '成功'
      redirect_to sights_path
    else
      flash[:notice] = '失敗'
      redirect_to root_path
    end
  end

  def destroy
    @sight = Sight.find(params[:id])
    @sight.member_id = current_member.id
    @sight.destroy
    flash[:notice] = '削除しました'
    redirect_to sights_path
  end

  private

  def sight_params
    params.require(:sight).permit(:address, :profile, :latitude, :longitude, :mapimage, :member_id)
  end
end
