class AddAgeToPandas < ActiveRecord::Migration[6.0]
  def change
    add_column :pandas, :age, :integer, default: 0, comment: :年龄
  end
end
