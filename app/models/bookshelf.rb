class Bookshelf < ApplicationRecord
	belongs_to :user
	belongs_to :book

	enum status: { 興味がある: 0, 読書中: 1, 読了: 2 }

    validates_uniqueness_of :book_id, scope: :user_id
	validates :user_id, :book_id, :status, presence: true

end
