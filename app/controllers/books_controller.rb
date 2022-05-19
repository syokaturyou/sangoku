class BooksController < ApplicationController
  def search
    # 楽天ブックスから検索 検索結果を配列に挿入してpaginate表示させる
    if params[:keyword]
      @books = []
      books = RakutenWebService::Books::Book.search(title: params[:keyword])
      books.each do |book|
        if book.title.include?("")
        @books.push(book)
        elsif book.item_caption.include?("")
        @books.push(book)
        elsif book.author.include?("")
        @books.push(book)
        end
      end
      if @books.present?
       @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
      end
    end
  end
end
