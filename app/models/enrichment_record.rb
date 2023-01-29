# == Schema Information
#
# Table name: enrichment_records
#
#  id                  :bigint           not null, primary key
#  is_input(是否录入)  :boolean          default(FALSE)
#  name                :string(50)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_enrichment_records_on_feeding_record_id  (feeding_record_id)
#  index_enrichment_records_on_panda_id           (panda_id)
#
class EnrichmentRecord < ApplicationRecord
  # 丰容
  belongs_to :panda
  belongs_to :feeding_record
  after_create :create_item

  def create_item
    update_columns(is_input: name.present?)
  end
end
