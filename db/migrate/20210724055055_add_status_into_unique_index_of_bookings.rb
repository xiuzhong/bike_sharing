class AddStatusIntoUniqueIndexOfBookings < ActiveRecord::Migration[6.1]
  OLD_INDEX = 'index_bike_date_on_active_bookings'
  NEW_INDEX = 'index_bike_date_status_on_active_bookings'

  def change
    remove_index :bookings, name: OLD_INDEX
    add_index(:bookings,
      [:bike_id, :status, :date], name: NEW_INDEX, where: "(status = 0)", unique: true)
  end
end
