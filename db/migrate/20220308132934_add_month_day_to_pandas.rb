class AddMonthDayToPandas < ActiveRecord::Migration[6.0]
  def change
    add_column :pandas, :month_day, :string, limit: 4
    add_column :pandas, :year, :integer, default: 0
  end
end
