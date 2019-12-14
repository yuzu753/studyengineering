class RecommendedsController < ApplicationController
	before_action :authenticate_user!

	def create
	  recommend = Recommended.create(user_id: current_user.id, book_id: recommend_params[:book_id])
	  redirect_back(fallback_location: root_path)
	end

	def destroy
	  recommend = Recommended.find_by(user_id: current_user.id, book_id: recommend_params[:book_id])
      recommend.destroy
      redirect_back(fallback_location: root_path)
	end

	private

	def recommend_params
	  params.permit(:book_id)
	end

end
