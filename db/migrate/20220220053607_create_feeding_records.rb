class CreateFeedingRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :feeding_records do |t|
      t.integer  :user_id, comment: :记录人
      t.integer  :panda_id, comment: :熊猫
      t.datetime :time,    comment: :时间
      t.text     :Health_medicine, comment: :保健药品
      t.string   :wo_tou_input, limit: 10, comment: :窝头投给
      t.string   :wo_tou_ingest, limit: 10, comment: :窝头食入
      t.string   :apple_input, limit: 10, comment: :苹果投给
      t.string   :apple_ingest, limit: 10, comment: :苹果食入
      t.string   :collection, limit: 100, comment: :采集情况
      t.string   :spiritual, limit: 100, comment: :精神活动
      t.string   :bamboo_variety, limit: 50, comment: :竹子品种
      t.string   :bamboo_part, limit: 20, comment: :竹子部位
      t.string   :bamboo_input, limit: 10, comment: :竹子投给
      t.string   :bamboo_ingest, limit: 10, comment: :竹子食入
      t.string   :poop_texture, limit: 30, comment: :大便质地
      t.string   :poop_element, limit: 30, comment: :大便成分
      t.string   :poop_color, limit: 20, comment: :大便颜色
      t.string   :poop_quality, limit: 10, comment: :大便质量
      t.string   :mucus_texture, limit: 30, comment: :粘液质地
      t.string   :mucus_pain, limit: 30, comment: :粘液痛感
      t.string   :mucus_color, limit: 20, comment: :粘液颜色
      t.string   :mucus_quality, limit: 10, comment: :粘液质量
      t.string   :evaluation, limit: 200, comment: :综合评估
      t.timestamps
    end
    add_index :feeding_records, :user_id
    add_index :feeding_records, :panda_id
  end
end
