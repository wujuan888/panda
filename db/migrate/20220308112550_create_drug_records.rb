class CreateDrugRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :drug_records do |t|
      t.integer  :user_id, comment: :开药人
      t.integer  :panda_id, comment: :熊猫
      t.date     :date,     comment: :日期
      t.datetime :time,    comment: :时间
      t.string   :remark, limit: 300, comment: :备注
      t.string   :other, limit: 200, comment: :其它
      t.timestamps
    end
    add_index :drug_records, :user_id
    add_index :drug_records, :panda_id
  end
end
