class CreatePoopRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :poop_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string   :texture, limit: 50, comment: :大便质地
      t.string   :element, limit: 50, comment: :大便成分
      t.string   :color, limit: 30, comment: :大便颜色
      t.string   :quality, limit: 20, comment: :大便质量
      t.timestamps
    end
    add_index :poop_records, :panda_id
    add_index :poop_records, :feeding_record_id
  end
end
