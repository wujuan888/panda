class CreateEatRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :eat_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string 'name', limit: 100
      t.string 'amount', limit: 20
      t.timestamps
    end
    add_index :eat_records, :panda_id
    add_index :eat_records, :feeding_record_id
  end
end
