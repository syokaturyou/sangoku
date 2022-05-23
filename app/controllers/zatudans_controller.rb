class ZatudansController < ApplicationController
  # 雑談部屋。非ログイン状態で可能
  def index
    @newzatudan = Zatudan.new
    @zatudans = Zatudan.all.order(updated_at: 'DESC').page(params[:page]).per(20)
  end

  def create
    @zatudan = Zatudan.new(zatudan_params)
    @zatudan.save
    redirect_to zatudans_path
  end

  private

  def zatudan_params
    params.require(:zatudan).permit(:message)
  end
end
