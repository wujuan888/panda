class CreateComEvaluationRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :com_evaluation_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string   :collection, limit: 100, comment: :采集情况
      t.string   :spiritual, limit: 100, comment: :精神情况
      t.string   :other, limit: 100, comment: :其它情况
      t.timestamps
    end
    add_index :com_evaluation_records, :panda_id
    add_index :com_evaluation_records, :feeding_record_id
  end
end
