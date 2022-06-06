module Public
  class MembersController < ApplicationController
    def index
      @members = Member.all.order(created_at: 'ASC').page(params[:page]).per(10)
    end

    def show
      @member = Member.find(params[:id])
      @range = params[:range] # 過去回答と過去質問選択時に場合分け
      @posts = @member.posts.order(updated_at: 'DESC').page(params[:page]).per(10)
      @answers = @member.answers.order(updated_at: 'DESC').page(params[:page]).per(10)
    end

    # ログインしたユーザーだけ見えるようにcurrent_memberとする
    def edit
      @member = current_member
      # 作成したユーザーのみ編集可能
    end

    def update
      @member = current_member
      @member.update(member_params)
      @member.update(profileimage: nil) if params[:image_delete].present? # 画像なしの場合に既存画像削除
      flash[:notice] = 'ユーザー情報を更新しました'
      redirect_to public_member_path(@member)
    end

    def unsubscribe; end

    def withdrawal
      member = current_member
      member.update(is_deleted: true) # is_deletedという退会フラグを更新
      reset_session
      flash[:notice] = '退会致しました'
      redirect_to root_path
    end

    def member_params
      params.require(:member).permit(:name, :email, :profile, :profileimage)
    end
  end
end
