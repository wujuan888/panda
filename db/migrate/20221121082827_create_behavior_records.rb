class CreateBehaviorRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :behavior_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string  'name'
      t.timestamps
    end
    add_index :behavior_records, :panda_id
    add_index :behavior_records, :feeding_record_id
  end
end
