class CreateParentingRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :parenting_records do |t|
      t.datetime :time,    comment: :时间
      t.integer  :user_id, comment: :记录人
      t.integer  :panda_id, comment: :熊猫
      t.string   :breast_milk, limit: 10, comment: :母乳
      t.string   :artificial_milk, limit: 10, comment: :人工乳
      t.string   :skin_temperature, limit: 10, comment: :肤温
      t.string   :Box_temperature, limit: 10, comment: :箱温
      t.string   :humidity, limit: 10, comment: :湿度
      t.string   :breathe, limit: 10, comment: :呼吸
      t.string   :poop, limit: 20, comment: :大便
      t.string   :pee, limit: 20, comment: :小便
      t.string   :mental_state, limit: 100, comment: :精神状态
      t.timestamps
    end
    add_index :parenting_records, :user_id
    add_index :parenting_records, :panda_id
  end
end
