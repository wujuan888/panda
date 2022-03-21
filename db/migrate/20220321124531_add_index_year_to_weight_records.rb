class AddIndexYearToWeightRecords < ActiveRecord::Migration[6.0]
  def change
    add_index :weight_months, %i[year month]
    add_index :weight_months, :panda_id
  end
end
