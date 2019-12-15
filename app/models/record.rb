class Record < ApplicationRecord
	belongs_to :user

	validates :user_id, :title, :body, :studytime, presence: true
	validates :title, length: { maximum: 20 }
	validates :body, length: { maximum: 92 }

end
