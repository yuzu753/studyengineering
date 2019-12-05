class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|

      t.timestamps

      t.integer :user_id
      t.string :title
      t.string :isbn
      t.string :sales_date
      t.string :small_image_url
      t.string :medium_image_url
      t.integer :status

    end
  end
end
