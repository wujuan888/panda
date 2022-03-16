class AddMucusTimeToFeedingRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :feeding_records, :forage_time, :string, limit: 10, comment: :采食时间
    add_column :feeding_records, :mucus_time, :string, limit: 10, comment: :粘液时间
    remove_column :feeding_records, :mucus_color
  end
end
