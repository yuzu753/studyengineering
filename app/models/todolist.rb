class Todolist < ApplicationRecord
	belongs_to :user

	enum status: { 挑戦中: 0,達成: 1,未達: 2 }
end
