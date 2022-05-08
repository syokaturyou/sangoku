class HomesController < ApplicationController
  # お知らせ一覧とマップ一覧を表示
  def top
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    @sights = Sight.all
  end
end
