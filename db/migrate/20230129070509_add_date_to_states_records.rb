class AddDateToStatesRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :states_records, :date, :datetime, comment: :开始或结束日期
    remove_column :states_records, :start_date
    remove_column :states_records, :stop_date
  end
end
