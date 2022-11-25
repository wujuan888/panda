class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.integer 'user_id'
      t.string  'name', limit: 100
      t.timestamps
    end

    add_index :places, :name
  end
end
