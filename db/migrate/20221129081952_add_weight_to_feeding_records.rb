class AddWeightToFeedingRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :feeding_records, :weight, :string, limit: 100, comment: :体重
    add_column :feeding_records, :remark, :string, limit: 200, comment: :备注
  end
end
