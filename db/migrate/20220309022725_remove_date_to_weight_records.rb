class RemoveDateToWeightRecords < ActiveRecord::Migration[6.0]
  def change
    remove_column :weight_records, :date
    remove_column :drug_records, :date
    add_column :weight_records, :time, :datetime, comment: :时间
  end
end
