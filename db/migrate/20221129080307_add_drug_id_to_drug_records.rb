class AddDrugIdToDrugRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :drug_records, :drug_id, :integer, default: 0
    add_column :drug_records, :dose, :string, limit: 50, comment: :剂量
  end
end
