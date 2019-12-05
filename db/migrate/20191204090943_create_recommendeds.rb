class CreateRecommendeds < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendeds do |t|

      t.timestamps

      t.integer :user_id
      t.integer :book_id

    end
  end
end
