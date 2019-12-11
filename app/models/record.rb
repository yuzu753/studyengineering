class Record < ApplicationRecord
	belongs_to :user

	validates :user_id, :title, :body, :studytime, presence: true

end
