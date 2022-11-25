class CreateTrainRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :train_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string  'name', limit: 20
      t.integer 'result', default: 0, comment: :训练结果
      t.timestamps
    end
    add_index :train_records, :panda_id
    add_index :train_records, :feeding_record_id
  end
end
