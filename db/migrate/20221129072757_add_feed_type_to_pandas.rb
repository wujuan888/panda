class AddFeedTypeToPandas < ActiveRecord::Migration[6.0]
  def change
    add_column :pandas, :feed_type, :integer, default: 0, comment: :"饲养类型： 0： 育幼  1：饲养"
    remove_column :panda_records, :feed_type
  end
end
