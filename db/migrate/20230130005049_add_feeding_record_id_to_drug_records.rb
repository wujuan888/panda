class AddFeedingRecordIdToDrugRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :drug_records, :feeding_record_id, :integer
    add_index :drug_records, :feeding_record_id
  end
end
