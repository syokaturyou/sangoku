class Manager::MembersController < ApplicationController
  before_action:authenticate_admin!
  # 管理者側では全ての会員情報を管理可能
  def index
    @members = Member.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    if params[:image_delete].present? # 画像なしの場合に既存画像削除
      @member.update(profileimage: nil)
    else
      @member.update(member_params)
    end
    redirect_to manager_member_path(@member.id)
  end


  private
  def member_params
    params.require(:member).permit(:name, :email, :is_deleted, :profile, :profileimage)
  end

end
