class AddYearToWeightRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :weight_months, :year, :integer, comment: :年
    add_column :weight_months, :month, :integer, comment: :月
  end
end
