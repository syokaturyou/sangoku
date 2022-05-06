class MapsController < ApplicationController
  def index
    @maps = Map.all
    @map = Map.new
  end

  def create
    map = Map.new(map_params)
    if map.save
      flash[:notice] = '成功'
      redirect_to :action => 'index'
    else
      flash[:notice] = '失敗'
      redirect_to :action => 'index'
    end
  end

  def destroy
    map = Map.find(params[:id])
    map.destroy
    flash[:notice] = '削除しました'
    redirect_to action: :index
  end

  private

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude, :profile)
  end
end
