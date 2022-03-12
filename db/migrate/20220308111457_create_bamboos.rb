class CreateBamboos < ActiveRecord::Migration[6.0]
  def change
    create_table :bamboos do |t|
      t.string :name, limit: 30
      t.timestamps
    end
  end
end
