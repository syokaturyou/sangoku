class HomesController < ApplicationController
  # お知らせ一覧を表示
  def top
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
    @sights = Sight.all.order(updated_at: 'DESC').page(params[:page]).per(4)
  end
end
