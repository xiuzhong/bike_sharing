class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :bike, foreign_key: true
      t.datetime :date, null: false
      t.string :user_full_name, null: false

      t.timestamps
    end
  end
end
