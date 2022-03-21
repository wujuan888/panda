class AddInitWeightToWeightMonths < ActiveRecord::Migration[6.0]
  def change
    add_column :weight_months, :init_weight, :string
  end
end
