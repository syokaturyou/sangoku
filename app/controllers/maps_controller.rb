class MapsController < ApplicationController
  def index
    @maps = Map.all
    @newmap = Map.new
  end

  def new
    @newmap = Map.new
    @maps = Map.all
  end

  def create
    @newmap = Map.new(map_params)
    if @newmap.save
      flash[:notice] = '成功'
      # redirect_to root_path
      redirect_to root_path
    else
      flash[:notice] = '失敗'
      redirect_to root_path
    end
  end

  def destroy
    @map = Map.find(params[:id])
    @map.destroy
    flash[:notice] = '削除しました'
    redirect_to root_path
  end

  private

  def map_params
    params.require(:map).permit(:address, :profile)
  end
end
