class CreateWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :weight_records do |t|
      t.integer  :user_id, comment: :记录人
      t.integer  :panda_id, comment: :熊猫
      t.datetime   :date, comment: :日期
      t.string     :weight, limit: 10, comment: :体重
      t.string     :daily_gain, limit: 10, comment: :日增重
      t.string     :feed_intake, limit: 10, comment: :采食量
      t.string     :feed_ratio, limit: 10, comment: :采食比
      t.string     :other, limit: 100, comment: :其它
      t.timestamps
    end
    add_index :weight_records, :user_id
    add_index :weight_records, :panda_id
  end
end
