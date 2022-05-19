class BooksController < ApplicationController
  def search
    if params[:keyword]
      @counts = RakutenWebService::Books::Book.search(title: params[:keyword])
      @books = []
      @range = params[:range]
      case @range
      when 'キーワード'
        books = RakutenWebService::Books::Book.search(title: params[:keyword])
        books.each do |book|
          if book.item_caption.include?("")
           @books.push(book)
          end
        end
      when '著者'
        books = RakutenWebService::Books::Book.search(author: params[:keyword])
        books.each do |book|
          if book.author.include?("")
           @books.push(book)
          end
        end
      end
      if @books.present?
       @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
      end
    end
  end
end
