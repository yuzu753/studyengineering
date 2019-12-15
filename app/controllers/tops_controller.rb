class TopsController < ApplicationController

	def top
	  #技術書ランキング
	  @book_ranks = Book.find(Recommended.group(:book_id).order('count(book_id) desc').limit(8).pluck(:book_id))

	  #総合学習時間ランキング  SQLの計算に任せるActiveRecord
	  studytime_arry = []
	  User.all.each do |u|
	  	studytime_arry << [u.id, u.records.sum(:studytime)]  #[[user.id, title_studytime], [...], [...]...]  二重配列にする
	  end

	  studytime_hash = {}
	  studytime_hash = Hash[*studytime_arry.flatten]   #{"user.id"=>title_studytime, ""=>,""=>}  ハッシュ化する
	  sutdytime_sort = studytime_hash.sort_by{ | k, v | v }.reverse  #ハッシュバリューの大きい順に並べ替えして配列化  [[user.id, title_studytim], [...] ...]
	  i = 0
	  @study_ranks = []

	  8.times do
	  	if sutdytime_sort[i].present?
	  	  @study_ranks << User.find(sutdytime_sort[i][0])  #user.idでユーザーの情報をDBから取ってきてインスタンス変数に入れる
	  	end
	  	i +=1
	  end

	  #月間学習時間ランキング
	  studytime_arry = []
	  User.all.each do |u|
	  	studytime_arry << [u.id, u.records.where("created_at > :date", date: Date.today - 30).sum(:studytime)]
	  end

	  studytime_hash = {}
	  studytime_hash = Hash[*studytime_arry.flatten]
	  sutdytime_sort = studytime_hash.sort_by{ | k, v | v }.reverse
	  i = 0
	  @monthly_study_ranks = []

	  8.times do
	  	if sutdytime_sort[i].present?
	  	  @monthly_study_ranks << User.find(sutdytime_sort[i][0])
	  	end
	  	i +=1
	  end

	  #週間学習時間ランキング
	  studytime_arry = []
	  User.all.each do |u|
	  	studytime_arry << [u.id, u.records.where("created_at > :date", date: Date.today - 7).sum(:studytime)]
	  end

	  studytime_hash = {}
	  studytime_hash = Hash[*studytime_arry.flatten]
	  sutdytime_sort = studytime_hash.sort_by{ | k, v | v }.reverse
	  i = 0
	  @weekly_study_ranks = []

	  8.times do
	  	if sutdytime_sort[i].present?
	  	  @weekly_study_ranks << User.find(sutdytime_sort[i][0])
	  	end
	  	i +=1
	  end

	end

	def privacy
	end
end
