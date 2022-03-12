class CreatePandaRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :panda_records do |t|
      t.integer :count, default: 0, comment: :熊猫总数量
      t.integer :f_count, default: 0, comment: :雄性数量
      t.integer :m_count, default: 0, comment: :雌性数量
      t.integer :pregnant_count, default: 0, comment: :怀孕数量
      t.integer :ill_count, default: 0, comment: :生病数量
      t.integer :lease_count, default: 0, comment: :租借数量
      t.timestamps
    end
  end
end
