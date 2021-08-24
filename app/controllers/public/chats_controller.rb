class Public::ChatsController < ApplicationController
  def show
    # どのユーザーとチャットするかを取得。
    @member = Member.find(params[:id])
    # カレントユーザーのmember_roomにあるroom_idの値の配列をroomsに代入。
    rooms = current_member.member_rooms.pluck(:room_id)
     # member_roomモデルから
      # member_idがチャット相手のidが一致するものと、
      # room_idが上記roomsのどれかに一致するレコードを
      # member_roomsに代入。
    member_rooms = MemberRoom.find_by(member_id: @member.id, room_id: rooms)

    # もしuser_roomが空でないなら
    unless member_rooms.nil?
      # @roomに上記user_roomのroomを代入
      @room = member_rooms.room
    else
      # それ以外は新しくroomを作り、
      @room = Room.new
      @room.save
      # user_roomをカレントユーザー分とチャット相手分を作る
      MemberRoom.create(member_id: current_member.id, room_id: @room.id)
      MemberRoom.create(member_id: @member.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  def create
    @chat = current_member.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
