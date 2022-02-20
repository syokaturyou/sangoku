class Manager::MembersController < ApplicationController
  before_action:authenticate_admin!
  # 管理者側では全ての会員情報を管理可能
  def index
    @members = Member.all.order(created_at: 'ASC').page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @range = params[:range] # 過去回答と過去質問選択時に場合分け
    @posts = @member.posts.order(updated_at: 'DESC').page(params[:page]).per(10)
    @answers = @member.answers.order(updated_at: 'DESC').page(params[:page]).per(10)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    @member.update(profileimage: nil) if params[:image_delete].present? # 画像なしの場合に既存画像削除
    flash[:notice] = 'ユーザー情報を更新しました'
    redirect_to manager_member_path(@member.id)
  end


  private
  def member_params
    params.require(:member).permit(:name, :email, :is_deleted, :profile, :profileimage)
  end

end
