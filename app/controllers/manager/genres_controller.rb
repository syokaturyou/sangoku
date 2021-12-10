class Manager::GenresController < ApplicationController
  # ジャンル名新規登録・更新は管理者側で可能
  def index
    @genres = Genre.all.order(id: 'DESC').page(params[:page]).per(10)
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to manager_genres_path(@genre)
    else
      render :edit
    end
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to manager_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
