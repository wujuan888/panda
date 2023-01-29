class AddDateRecordToFeedingRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :feeding_records, :date_record, :integer, comment: :日期
    add_column :pandas, :feeding_type, :integer, default: 0, comment: :"类型 1 育幼 0 饲养"
    add_column :feeding_records, :feeding_type, :integer, default: 0, comment: :"类型 1 育幼 0 饲养"
  end
end
