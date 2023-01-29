class AddIsInputToEatRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :eat_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :poop_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :mucus_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :enrichment_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :behavior_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :com_evaluation_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :milk_records, :is_input, :boolean, default: false, comment: :是否录入
    add_column :temperature_records, :is_input, :boolean, default: false, comment: :是否录入
   end
end
