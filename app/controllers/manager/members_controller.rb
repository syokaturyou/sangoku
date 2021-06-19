class Manager::MembersController < ApplicationController
  before_action:authenticate_admin!
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
    if @member.update(member_params)
      redirect_to manager_member_path(@member.id)
    else
      render :edit
    end
  end


  private
  def member_params
    params.require(:member).permit(:name, :email, :is_deleted)
  end

end
