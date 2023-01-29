class AddRoomIdToDormitoryRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :dormitory_records, :room_id, :integer, default: 0
  end
end
