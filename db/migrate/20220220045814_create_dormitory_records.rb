class CreateDormitoryRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :dormitory_records do |t|
      t.integer :dormitory_id
      t.integer :panda_id,  comment: :地址
      t.integer :user_id, comment: '负责人'
      t.string :name, limit: 30
      t.string :address, limit: 20, comment: :地址
      t.timestamps
    end
    add_index :dormitory_records, :dormitory_id
    add_index :dormitory_records, :panda_id
  end
end
