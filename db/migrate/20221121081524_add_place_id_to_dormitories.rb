class AddPlaceIdToDormitories < ActiveRecord::Migration[6.0]
  def change
    add_column :dormitories, :place_id, :integer
    add_column :dormitories, :district_id, :integer

    add_index :dormitories, %i[place_id district_id], name: :place
  end
end
