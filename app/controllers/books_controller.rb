class BooksController < ApplicationController
  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
end
