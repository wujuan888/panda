class CreatePandas < ActiveRecord::Migration[6.0]
  def change
    create_table :pandas do |t|
      t.integer :dormitory_id
      t.integer :user_id, comment: :新建人员
      t.string :head_url
      t.string :name, limit: 30
      t.date   :birth_date
      t.string :initial_weight, limit: 10, comment: :初始体重
      t.integer :gender, default: 0, comment: '0：未知 1：雄性 2：雌性'
      t.integer :father_id, comment: :父亲
      t.integer :father_father_id, comment: :父亲的父亲
      t.integer :father_mother_id, comment: :父亲的母亲
      t.integer :mother_id, comment: :母亲
      t.integer :mother_father_id, comment: :母亲的父亲
      t.integer :mother_mother_id, comment: :母亲的母亲
      t.string  :pedigree_number, limit: 12, comment: :谱系号
      t.string  :remark, limit: 200, comment: :备注
      t.boolean :is_pregnant, default: false, comment: :是否怀孕
      t.boolean :is_ill, default: false, comment: :是否生病
      t.boolean :is_lease, default: false, comment: :是否租借
      t.timestamps
    end
    add_index :pandas, :name

  end
end
