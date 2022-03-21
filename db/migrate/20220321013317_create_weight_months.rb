class CreateWeightMonths < ActiveRecord::Migration[6.0]
  def change
    create_table :weight_months do |t|
      t.integer  :panda_id, comment: :熊猫
      t.datetime  :date, comment: :日期
      t.string    :weight, limit: 10, comment: :体重
      t.string    :add, limit: 10, comment: :增长体重
      t.timestamps
    end
  end
end
