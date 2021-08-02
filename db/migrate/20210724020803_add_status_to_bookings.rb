class AddStatusToBookings < ActiveRecord::Migration[6.1]
  def up
    add_column :bookings, :status, :integer, default: 0
    add_index :bookings, :status
  end

  def down
    remove_column :bookings, :status
  end
end
