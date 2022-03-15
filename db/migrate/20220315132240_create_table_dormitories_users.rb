class CreateTableDormitoriesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :table_dormitories_users do |t|
      t.belongs_to :dormitory
      t.belongs_to :user
    end
  end
end
