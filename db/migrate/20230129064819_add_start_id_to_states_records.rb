class AddStartIdToStatesRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :states_records, :start_id, :integer, comment: :特殊状态开始id
  end
end
