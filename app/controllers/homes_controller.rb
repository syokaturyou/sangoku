class HomesController < ApplicationController
  # お知らせを表示
  def top
    @articles = Article.all.order(updated_at: 'DESC').page(params[:page]).per(10)
  end

  def design
  end

end
