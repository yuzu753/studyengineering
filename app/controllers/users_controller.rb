class UsersController < ApplicationController

	def show
		@interest_books = current_user.bookshelves.where(status: 0)
		@reading_books = current_user.bookshelves.where(status: 1)
		@read_books = current_user.bookshelves.where(status: 2)
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
