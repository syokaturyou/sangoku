class Manager::GenresController < ApplicationController
  # ジャンル名新規登録・更新は管理者側で可能
  def index
    @genres = Genre.all.order(id: 'ASC').page(params[:page]).per(10)
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = 'ジャンルを更新しました'
      redirect_to manager_genres_path(@genre)
    else
      render :edit
    end
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = 'ジャンルを新規作成しました'
      redirect_to manager_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    flash[:notice] = 'ジャンルを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
