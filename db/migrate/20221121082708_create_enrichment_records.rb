class CreateEnrichmentRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :enrichment_records do |t|
      t.integer 'panda_id'
      t.integer 'feeding_record_id'
      t.string  'name', limit: 50
      t.timestamps
    end
    add_index :enrichment_records, :panda_id
    add_index :enrichment_records, :feeding_record_id
  end
end
