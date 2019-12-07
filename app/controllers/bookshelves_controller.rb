class BookshelvesController < ApplicationController

	def create
	  book = Book.find_or_initialize_by(book_code: params[:book_code])

	  if book.new_record?
	    results = RakutenWebService::Books::Book.search(isbn: params[:book_code])
	    book = Book.new(read(results.first))
	    book.save
	  end

	  bookshelf = Bookshelf.new
	  bookshelf.user_id = current_user.id
	  bookshelf.book_id = book.id
	  if bookshelf.save
	    flash[:bookget] = "本棚へ追加しました"
		redirect_to user_path(current_user.id)
	  else
	  	root_path
	  end
	end

	def update
	  bookshelf = current_user.bookshelves.find(params[:id])
	    if bookshelf.update(bookshelf_update_params)
		  flash[:success_update]  = "ステータスを更新しました"
		  redirect_to user_path(current_user.id)
	    end
	end

	def destroy
	  bookshelf = current_user.bookshelves.find(params[:id])
      bookshelf.destroy
      redirect_to user_path(current_user.id)
	end

	private

	def bookshelf_params
		params.require(:bookshelf).permit(:user_id, :book_id)
	end

	def bookshelf_update_params
		params.require(:bookshelf).permit(:status)
	end

end
