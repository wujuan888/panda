class AddStatesTypeToStatesRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :states_records, :states_type, :integer, comment: :"0: 开始  1： 结束"
  end
end
