class RecordsController < ApplicationController
	before_action :authenticate_user!

	def index
	  @records = current_user.records.order("id DESC").page(params[:page]).per(10)
	  @record = Record.new
	end

	def edit
	  @record = Record.find(params[:id])
	  if @record.user_id != current_user.id
      	redirect_to root_path
      end
	end

	def create
	  record = Record.new(record_params)
      record.user_id = current_user.id
      if  current_user.records.blank? || current_user.records.last.created_at.strftime("%Y-%m-%d") != Date.today.strftime("%Y-%m-%d")
        if  record.save
      	  totalstudytime = current_user.records.sum(:studytime) + record.studytime
          record.until_today_studytime = totalstudytime
          record.save
          flash[:add_record] = "本日の進捗を追加しました"
          @client.update("#{@article.title}\r")
          redirect_to records_path
        else
          flash[:miss_add_record] = "学習項目と期限を入力してください"
          redirect_to records_path
        end
      else
      	flash[:miss_sameday_record] = "同じ日に学習記録があります"
        redirect_to records_path
      end
	end

	def update
	  record = current_user.records.find(params[:id])
	  if record.update(record_params)
	  	allrecords =  current_user.records.all

	  	allrecords.each.with_index(0) do |re, e|
	      i = 0
	      s = 0
	      until_total_studytime = 0
	  	  while s <= e
	  	  	until_total_studytime += allrecords[i].studytime
	  	  	i += 1
	  	  	s += 1
	  	  end
	  	  re.until_today_studytime = until_total_studytime
	  	  re.save
        end

	    flash[:success_record_update]  = "進捗内容を更新しました"
		redirect_to records_path
	  else
	  	flash[:miss_recored_update]  = "項目を埋めて下さい"
		redirect_to records_path
	  end
	end

	private

	def record_params
	  params.require(:record).permit(:title, :body, :studytime, :until_today_studytime)
	end

	def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['Twitter_API_KEY']
      config.consumer_secret = ENV['Twitter_API_secret_KEY']
      config.access_token = ENV['Twitter_Access_token']
      config.access_token_secret = ENV['Twitter_Access_token_secret']
    end
  end

end
