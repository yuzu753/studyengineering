class TodolistsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_todolist, only: [:update, :destroy, :congratulations]

	def index
	  #TODOステータス別のソート機能
      if  params[:todo_status].to_i == 1
      	@todolists = current_user.todolists.where(status: 0).order(:deadline).page(params[:page]).per(10)

      elsif  params[:todo_status].to_i == 2
      	@todolists = current_user.todolists.where(status: 1).order("id DESC").page(params[:page]).per(10)

      elsif  params[:todo_status].to_i == 3
      	@todolists = current_user.todolists.where(status: 2).order("id DESC").page(params[:page]).per(10)

      else
	    @todolists = current_user.todolists.order("id DESC").page(params[:page]).per(10)

	  end

	  @todolist = Todolist.new
	  @todolists.each do |todo|
	  	if current_user.ckeck_date(todo) < 0 && todo.status == "challenge"
	  		todo.status = 2
	  		todo.save
	  	end
	  end
	  render :index
	end

	def edit
      @todolist = Todolist.find(params[:id])
      if @todolist.user_id != current_user.id
      	redirect_to root_path
      end
	end

	def create
	  @todolists = current_user.todolists.order("id DESC").page(params[:page]).per(10)
	  todolist = Todolist.new(todolist_params)
      todolist.user_id = current_user.id
      if todolist.save
        flash[:add_todo] = "リストに目標を追加しました"
        render :index
      else
        flash[:miss_add_todo] = "やる事と期限を入力してください"
        render :message
      end
	end

	def update
	  if @thetodolist.update(todolist_update_params)
	    flash[:success_todo_update]  = "Todoリストを更新しました"
		redirect_to todolists_path
	  else
	  	flash[:miss_todo_update]  = "項目を埋めて下さい"
		redirect_to edit_todolist_path(@thetodolist.id)
	  end
	end

	def destroy
	  @todolists = current_user.todolists.where(status: 0).order(:deadline).page(params[:page]).per(10)
      @thetodolist.destroy
      flash[:destroy_todo] = "リストを削除しました"
      render :index
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
