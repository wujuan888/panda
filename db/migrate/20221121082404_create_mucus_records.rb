class CreateMucusRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :mucus_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string   :texture, limit: 30, comment: :粘液质地
      t.string   :pain, limit: 30, comment: :粘液痛感
      t.string   :color, limit: 20, comment: :粘液颜色
      t.string   :quality, limit: 10, comment: :粘液质量
      t.datetime :record_date
      t.timestamps
    end
    add_index :mucus_records, :panda_id
    add_index :mucus_records, :feeding_record_id
  end
end
