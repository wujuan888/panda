class CreateTableDrugsDrugRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :table_drugs_drug_records do |t|
      t.belongs_to :drug
      t.belongs_to :drug_record
    end
  end
end
