class ChangeStatesToPandas < ActiveRecord::Migration[6.0]
  def change
    change_column :pandas, :states, :string, limit: 50, default: '', comment: :特殊状态
  end
end
