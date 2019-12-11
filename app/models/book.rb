class Book < ApplicationRecord
	has_many :recommendeds
	has_many :bookshelves
	has_many :users, { through: :bookshelves }
	has_many :recommended_users, through: :recommended, source: :user

	validates :title, :url, :book_code, :medium_image_url, presence: true

end
