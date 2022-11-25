# == Schema Information
#
# Table name: enrichment_records
#
#  id                :bigint           not null, primary key
#  name              :string(50)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  feeding_record_id :integer
#  panda_id          :integer
#
# Indexes
#
#  index_enrichment_records_on_feeding_record_id  (feeding_record_id)
#  index_enrichment_records_on_panda_id           (panda_id)
#
class EnrichmentRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
end
