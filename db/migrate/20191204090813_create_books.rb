class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|

      t.timestamps

      t.string :title
      t.string :url
      t.string :book_code
      t.string :sales_date
      t.string :price
      t.string :author
      t.string :caption
      t.string :review_average
      t.string :review_count
      t.string :small_image_url
      t.string :medium_image_url
      t.string :large_image_url

    end
  end
end
