class CreateBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :bikes do |t|
      t.string :name, null: false
      t.text :description
      t.string :image_name, null: false
      t.decimal :price_per_day, precision: 10, scale: 2, default: "0.0"

      t.timestamps
    end
  end
end
