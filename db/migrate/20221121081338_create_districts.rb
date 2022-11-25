class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.integer 'place_id'
      t.integer 'user_id'
      t.string  'name', limit: 100
      t.timestamps
    end

    add_index :districts, :name
    add_index :districts, :place_id
  end
end
