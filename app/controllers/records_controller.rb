class RecordsController < ApplicationController

	def index
	  @records = current_user.records.all.page(params[:page]).per(10)
	  @record = Record.new
	end

	def edit
	  @record = current_user.records.find(params[:id])
	end

	def create
	  record = Record.new(record_params)
      record.user_id = current_user.id
      totalstudytime = current_user.records.sum(:studytime) + record.studytime
      record.until_today_studytime = totalstudytime
      if record.save
        flash[:add_record] = "本日の進捗を追加しました"
        redirect_to records_path
      else
        flash[:miss_add_record] = "やる事と期限を入力してください"
        redirect_to records_path
      end
	end

	def update
	  record = current_user.records.find(params[:id])
	  if record.update(record_update_params)
	  	allrecords =  current_user.records.all

	  	allrecords.each do |re|
	      i = 0
	      s = 1
	      until_total_studytime = 0
	  	  while s <= re.id
	  	  	until_total_studytime += allrecords[i].studytime
	  	  	i += 1
	  	  	s += 1
	  	  end
	  	  re.until_today_studytime = until_total_studytime
	  	  re.save
        end

	    flash[:success_record_update]  = "学習進捗内容を更新しました"
		redirect_to records_path
	  else
	  	flash[:miss_recored_update]  = "項目を埋めて下さい"
		render 'edit'
	  end
	end

	private

	def record_params
	  params.require(:record).permit(:title, :body, :studytime, :until_today_studytime)
	end

	def record_update_params
	  params.require(:record).permit(:title, :body, :studytime, :until_today_studytime)
	end

end
