class AddDrugsToDrugRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :drug_records, :drugs, :string, limit: 500, comment: :药物
  end
end
