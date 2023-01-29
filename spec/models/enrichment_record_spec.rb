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
require 'rails_helper'

RSpec.describe EnrichmentRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
