class CreateDormitoriesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :dormitories_users do |t|
      t.belongs_to :dormitory
      t.belongs_to :user
    end
    drop_table :table_dormitories_users
  end
end
