class AddBikeIdDateUniqueIndexToBookings < ActiveRecord::Migration[6.1]
  INDEX = 'index_bike_date_on_active_bookings'
  def up
    # status '0' is active
    add_index :bookings, [:date, :bike_id], name: INDEX, where: "(status = 0)", unique: true
  end

  def down
    remove_index :bookings, name: INDEX
  end
end
