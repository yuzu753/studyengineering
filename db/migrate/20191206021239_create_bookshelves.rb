class CreateBookshelves < ActiveRecord::Migration[5.2]
  def change
    create_table :bookshelves do |t|

      t.timestamps

      t.integer :user_id
      t.integer :book_id
      t.integer :status, default: 0
    end
  end
end
