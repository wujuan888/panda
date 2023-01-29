class CreateTemperatureRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :temperature_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string   :body, limit: 20, comment: :体温
      t.string   :box, limit: 20, comment: :箱温
      t.timestamps
    end
    add_index :temperature_records, :panda_id
    add_index :temperature_records, :feeding_record_id
  end
end
