class UsersController < ApplicationController

	def show
	  #TODOリスト表示用のインスタンス変数 && 未達のステータス更新用の処理
	  if current_user.todolists.present?
	    @todolists = current_user.todolists.find(Todolist.order(id: :desc).limit(7).pluck(:id))
	    @todolists.each do |todo|
	  	  if current_user.ckeck_date(todo) < 0 && todo.status == "challenge"
	  		todo.status = 2
	  		todo.save
	  	  end
	    end
	  end

      #学習時間のグラフ用のインスタンス変数
	  @studytimes = current_user.records.all
	  @studychart = []
	  @studytimes.each do |s|
	  	@studychart << [s.created_at, s.until_today_studytime]
	  end


      #TODOの達成率のチャート用インスタンス変数
	  @completes = current_user.todolists.where(status: 1)
	  @unachieved = current_user.todolists.where(status: 2)
	  @todochart = [['達成数', @completes.count], ['未達数', @unachieved.count]]

      #楽天ブックスからの取得データの表示用インスタンス変数
	  @interest_books = current_user.bookshelves.where(status: 0)
	  @reading_books = current_user.bookshelves.where(status: 1)
	  @read_books = current_user.bookshelves.where(status: 2)

	  #技術書お勧め用のインスタンス変数
	  @recommned = Recommended.new
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
	  user = current_user
      user.destroy
      redirect_to root_path
	end

	private

	def user_update_params
      params.require(:user).permit(:name, :email, :password, :github_url, :twitter_url, :wantedly_url)
	end

end
