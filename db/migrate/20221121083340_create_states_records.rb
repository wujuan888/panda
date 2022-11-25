class CreateStatesRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :states_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string 'name'
      t.date   'start_date'
      t.date   'stop_date'
      t.string 'district', limit: 100, comment: :地区
      t.string 'institution', limit: 100, comment: :机构
      t.boolean 'is_stop', default: false, comment: :是否结束
      t.timestamps
    end
    add_index :states_records, :panda_id
    add_index :states_records, :feeding_record_id
  end
end
