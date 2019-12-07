class Bookshelf < ApplicationRecord
	belongs_to :user
	belongs_to :book

	enum status: { 興味がある: 0,読書中: 1,読了: 2 }

end
