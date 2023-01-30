class RemoveFeedTypeToPandas < ActiveRecord::Migration[6.0]
  def change
    remove_column :pandas, :feed_type
  end
end
