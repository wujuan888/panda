class CreateMilkRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :milk_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string   :breast_milk, limit: 20, comment: :母乳处奶量
      t.string   :su_breast_milk, limit: 20, comment: :补母乳
      t.string   :artificial_milk, limit: 20, comment: :人工奶
      t.string   :milks, limit: 20, comment: :总奶量
      t.timestamps
    end
    add_index :milk_records, :panda_id
    add_index :milk_records, :feeding_record_id
  end
end