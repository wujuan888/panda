class AddPandaCountToDormitories < ActiveRecord::Migration[6.0]
  def change
    add_column :dormitories, :panda_count, :integer, default: 0, comment: :熊猫数量
  end
end
