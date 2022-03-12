class CreateDrugs < ActiveRecord::Migration[6.0]
  def change
    create_table :drugs do |t|
      t.string :name, limit: 30
      t.integer :drug_type, default: 0, comment: :"0 药品  1 保健药品"
      t.timestamps
    end
  end
end
