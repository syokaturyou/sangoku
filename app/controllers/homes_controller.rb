class HomesController < ApplicationController
  # お知らせ一覧とマップ一覧を表示
  def top
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    # いいね数の多い順に表示させる
    @sights = Sight.includes(:liked_members).sort { |a, b| b.liked_members.size <=> a.liked_members.size }
  end
end
