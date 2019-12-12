class TopsController < ApplicationController

	def top
	  #技術書ランキング
	  @book_ranks = Book.find(Recommended.group(:book_id).order('count(book_id) desc').limit(5).pluck(:book_id))

	  #学習時間ランキング
	  studytime_arry = []
	  User.all.each do |u|
	  	studytime_arry << [u.id, u.records.sum(:studytime)]  #[[user.id, title_studytime], [...], [...]...]  二重配列にする
	  end

	  studytime_hash = {}
	  studytime_hash = Hash[*studytime_arry.flatten]   #{"user.id"=>title_studytime, ""=>,""=>}  ハッシュ化する
	  sutdytime_sort = studytime_hash.sort_by{ | k, v | v }.reverse  #ハッシュバリューの大きい順に並べ替えして配列化  [[user.id, title_studytim], [...] ...]
	  study_userid = []
	  i = 0
	  2.times do
	  	study_userid << sutdytime_sort[i][0]
	  	i +=1
	  end

	  @study_ranks = []
      s = 0
      2.times do
	  	@study_ranks << User.find(study_userid[s])  #user.idでユーザーの情報をDBから取ってきてインスタンス変数に入れる
	  	s +=1
	  end

	end

	def privacy
	end
end
