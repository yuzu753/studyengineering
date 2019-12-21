class TopsController < ApplicationController

	def top
	  #技術書ランキング
	  @book_ranks = Book.find(Recommended.group(:book_id).order('count(book_id) desc').limit(8).pluck(:book_id))

	  #総合学習時間ランキング
	  @study_ranks = User.find(Record.group(:user_id).order('sum(studytime) desc').limit(8).pluck(:user_id))

	  #月間学習時間ランキング
	  @monthly_study_ranks = User.find(Record.where("created_at > :date", date: Date.today - 30).group(:user_id).order('sum(studytime) desc').limit(8).pluck(:user_id))

	  #週間学習時間ランキング
	  @weekly_study_ranks = User.find(Record.where("created_at > :date", date: Date.today - 7).group(:user_id).order('sum(studytime) desc').limit(8).pluck(:user_id))
	end

	def privacy
	end
end
