class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.integer :panda_id
      t.string  :url
      t.string  :sm_url
      t.integer :item_id
      t.string  :item_type, limit: 30
      t.timestamps
    end
    add_index :attachments, %i[item_id item_type]
    add_index :attachments, :panda_id
  end
end
