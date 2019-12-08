class CreateTodolists < ActiveRecord::Migration[5.2]
  def change
    create_table :todolists do |t|

      t.timestamps

      t.integer :user_id
      t.string :body
      t.date :deadline
      t.integer :status, default: 0
    end
  end
end
