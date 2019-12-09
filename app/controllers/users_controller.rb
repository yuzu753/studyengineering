class UsersController < ApplicationController

	def show
	  @todolists = current_user.todolists.find(Todolist.order(id: :desc).limit(7).pluck(:id))
	  @interest_books = current_user.bookshelves.where(status: 0)
	  @reading_books = current_user.bookshelves.where(status: 1)
	  @read_books = current_user.bookshelves.where(status: 2)
	  @recommned = Recommended.new
	  completes = current_user.todolists.where(status: 1)
	  unachieved = current_user.todolists.where(status: 2)
	  @todochart = [['達成数', completes.count], ['未達数', unachieved.count]]
	end

	def edit
	  @user = current_user
	end

	def update
      user = current_user
      if user.update(user_update_params)
	    flash[:notice] = '登録情報を更新しました'
	    redirect_to user_path(current_user.id)
	  else
	  	render 'edit'
	  end
	end

	def destroy
	end

	private

	def user_update_params
      params.require(:user).permit(:name, :email, :password, :github_url, :twitter_url, :wantedly_url)
	end

end
