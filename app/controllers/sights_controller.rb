class SightsController < ApplicationController
  def new
    @newsight = Sight.new
  end

  def index
    # いいね数の多い順に表示させる
    @sights = Sight.includes(:liked_members).sort { |a, b| b.liked_members.size <=> a.liked_members.size }
  end

  def edit
    @sight =  Sight.find(params[:id])
    # 作成したユーザーのみ編集可能
    return if @sight.member == current_member

    redirect_to new_sight_path
  end

  def show
    @sight =  Sight.find(params[:id])
  end

  def create
    @newsight = Sight.new(sight_params)
    if @newsight.save
      flash[:notice] = '成功'
      redirect_to sights_path
    else
      flash[:notice] = '失敗'
      redirect_to root_path
    end
  end

  def update
    @sight = Sight.find(params[:id])
    @sight.update(sight_params)
    flash[:notice] = 'マップを更新しました'
    redirect_to sights_path
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
