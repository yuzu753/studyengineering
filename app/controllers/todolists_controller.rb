class TodolistsController < ApplicationController
	before_action :set_todolist, only: [:update, :destroy, :congratulations]

	def index
	  @todolists = current_user.todolists.all.page(params[:page]).per(10)
	  @todolist = Todolist.new
	  @todolists.each do |todo|
	  	if current_user.ckeck_date(todo) < 0 && todo.status == "challenge"
	  		todo.status = 2
	  		todo.save
	  	end
	  end
	end

	def edit
      @todolist = current_user.todolists.find(params[:id])
	end

	def create
	  todolist = Todolist.new(todolist_params)
      todolist.user_id = current_user.id
      if todolist.save
        flash[:add_todo] = "todolistに目標を追加しました"
        redirect_to todolists_path
      else
        flash[:miss_add_todo] = "やる事と期限を入力してください"
        redirect_to todolists_path
      end
	end

	def update
	  if @thetodolist.update(todolist_update_params)
	    flash[:success_todo_update]  = "Todoリストを更新しました"
		redirect_to todolists_path
	  else
	  	flash[:miss_todo_update]  = "項目を項目を埋めて下さい"
		redirect_to edit_todolist_path(@thetodolist.id)
	  end
	end

	def destroy
      @thetodolist.destroy
      redirect_to todolists_path
	end

	def congratulations
      @thetodolist.congratulations!
      flash[:success_update]  = "達成おめでとうございます!!"
      redirect_to todolists_path
    end

	private

	def set_todolist
      @thetodolist = current_user.todolists.find(params[:id] || params[:todolist_id])
    end

	def todolist_params
	  params.require(:todolist).permit(:body, :deadline)
	end

	def todolist_update_params
	  params.require(:todolist).permit(:body, :deadline, :status)
	end

end
