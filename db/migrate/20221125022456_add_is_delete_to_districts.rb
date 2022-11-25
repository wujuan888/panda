class AddIsDeleteToDistricts < ActiveRecord::Migration[6.0]
  def change
    add_column :districts, :is_delete, :boolean, default: false, comment: :删除
    add_column :dormitories, :is_delete, :boolean, default: false, comment: :删除
    add_column :rooms, :is_delete, :boolean, default: false, comment: :删除
  end
end
