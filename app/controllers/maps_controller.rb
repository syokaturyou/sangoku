class MapsController < ApplicationController
  def index
    before_action :authenticate_member!
    @maps = Map.all
    @newmap = Map.new
  end

  def create
    @newmap = Map.new(map_params)
    if @newmap.save
      flash[:notice] = '成功'
      redirect_to maps_path
    else
      flash[:notice] = '失敗'
      redirect_to root_path
    end
  end

  def destroy
    @map = Map.find(params[:id])
    @map.destroy
    flash[:notice] = '削除しました'
    redirect_to maps_path
  end

  private

  def map_params
    params.require(:map).permit(:address, :profile, :latitude, :longitude)
  end
end
