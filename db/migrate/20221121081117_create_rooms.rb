class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer 'place_id'
      t.integer 'user_id'
      t.integer 'district_id'
      t.integer 'dormitory_id'
      t.string  'name', limit: 500
      t.timestamps
    end
    add_index :rooms, :name
    add_index :rooms, %i[place_id district_id dormitory_id], name: :place
  end
end
