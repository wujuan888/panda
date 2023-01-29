class AddItemIdToStatesRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :states_records, :item_id, :integer, comment: :特殊状态开始或结束id
    remove_column :states_records, :start_id
  end
end
