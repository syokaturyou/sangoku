class Public::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
  end

  #ログインしたユーザーだけ見えるようにcurrent_memberとする

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.update(member_params)
    redirect_to public_member_path(@member)
  end

   def unsubscribe
   end

   def withdrawal
     member = current_member
     #is_deletedという退会フラグを更新
     member.update(is_deleted: true)
     reset_session
     flash[:notice] = "退会致しました。"
     redirect_to root_path
   end

  def member_params
    params.require(:member).permit(:name, :email, :profile, :profileimage_id)
  end
end
