class AddTimeRecordToDrugRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :drug_records, :time_record, :string, comment: :"喂药时间（12:00）"
    add_column :mucus_records, :time_record, :string, comment: :"喂药时间（12:00）"
    remove_column :mucus_records, :record_date
  end
end
