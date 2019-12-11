class Todolist < ApplicationRecord
	belongs_to :user

	enum status: { challenge: 0, complete: 1, unachieved: 2 }

	validates :user_id, :body, :deadline, :status, presence: true
	validates :status, inclusion: { in: Todolist.statuses.keys }

	def congratulations!
      if challenge?
        complete!
      end
    end

end
