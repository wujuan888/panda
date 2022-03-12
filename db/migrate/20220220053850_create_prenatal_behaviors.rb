class CreatePrenatalBehaviors < ActiveRecord::Migration[6.0]
  def change
    create_table :prenatal_behaviors do |t|
      t.integer  :user_id, comment: :记录人
      t.integer  :panda_id, comment: :熊猫
      t.datetime :time,    comment: :时间
      t.string   :wo_tou, limit: 30, comment: :窝头
      t.string   :bamboo, limit: 30, comment: :竹子
      t.string   :poop, limit: 30, comment: :大便
      t.string   :remark, limit: 100, comment: :备注
      t.datetime :behavior_time, comment: :行为时间
      t.string   :behavior_event, limit: 50, comment: :事件
      t.string   :behavior_remark, limit: 100, comment: :行为备注
      t.timestamps
    end
    add_index :prenatal_behaviors, :user_id
    add_index :prenatal_behaviors, :panda_id
  end
end
