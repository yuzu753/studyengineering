class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|

      t.timestamps

      t.integer :user_id
      t.string :title
      t.text :body
      t.decimal :studytime
      t.decimal :until_today_studytime
    end
  end
end
