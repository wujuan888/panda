class CreateDormitories < ActiveRecord::Migration[6.0]
  def change
    create_table :dormitories do |t|
      t.string :name, limit: 30
      t.string :address, limit: 20, comment: :地址
      t.integer :user_id, comment: '负责人'
      t.string  :remark, limit: 200, comment: :备注
      t.timestamps
    end
    add_index :dormitories, :name
  end
end
