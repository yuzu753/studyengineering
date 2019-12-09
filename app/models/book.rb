class Book < ApplicationRecord
	has_many :recommendeds
	has_many :bookshelves
	has_many :users, { through: :bookshelves }
	has_many :recommended_users, through: :recommended, source: :user

end
