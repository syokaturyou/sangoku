class Manager::GenresController < ApplicationController
  before_action:authenticate_admin!
     def index
      @genres= Genre.all
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
       @genres= Genre.all
       render :index
      end
     end

     private
      def genre_params
       params.require(:genre).permit(:name)
      end
end
