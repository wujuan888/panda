class AddIsDeleteToPandas < ActiveRecord::Migration[6.0]
  def change
    add_column :pandas, :is_delete, :boolean, default: false, commont: :是否删除
    add_column :users, :role_remark, :string, limit: 50, commont: :职务备注
  end
end
