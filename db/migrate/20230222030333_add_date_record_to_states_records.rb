class AddDateRecordToStatesRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :states_records, :date_record, :integer, commnet: :饲养育幼日期
  end
end
