class AddIsDeathToPandas < ActiveRecord::Migration[6.0]
  def change
    add_column :pandas, :is_death, :boolean, default: false, comment: :是否死亡
    add_column :pandas, :states, :string, :limit => 100, comment: :特殊状态
    add_column :pandas, :place_id, :integer
    add_column :pandas, :district_id, :integer
    add_column :pandas, :room_id, :integer

    add_column :panda_records, :place_id, :integer
    add_column :panda_records, :pei_zhong_count, :integer, default: 0, comment: :配种数量
    add_column :panda_records, :fa_qin_count, :integer, default: 0, comment: :发情数量
    add_column :panda_records, :dai_zai_count, :integer, default: 0, comment: :带仔数量
    add_column :panda_records, :feed_type, :integer, default: 0, comment: :"饲养类型： 0： 育幼  1：饲养"
  end
end
