class BooksController < ApplicationController

    def search
        @books = []
        @title = params[:title]
        if @title.present?
          @books = search_items(@title)
        end
    end

  	def result
  	end

  	def detail
  	  results = RakutenWebService::Books::Book.search({
          isbn: params[:book_code]
        })
      @book = Book.new(read(results.first))
      @bookshelf = @book.bookshelves.build
  	end

end
