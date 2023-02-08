class AddDailyAddToFeedingRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :feeding_records, :daily_add, :string, default: '', comment: :日增重
  end
end
