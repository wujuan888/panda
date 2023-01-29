# == Schema Information
#
# Table name: mucus_records
#
#  id                             :bigint           not null, primary key
#  color(粘液颜色)                :string(20)
#  is_input(是否录入)             :boolean          default(FALSE)
#  pain(粘液痛感)                 :string(30)
#  quality(粘液质量)              :string(10)
#  texture(粘液质地)              :string(30)
#  time_record(喂药时间（12:00）) :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  feeding_record_id              :integer
#  panda_id                       :integer
#
# Indexes
#
#  index_mucus_records_on_feeding_record_id  (feeding_record_id)
#  index_mucus_records_on_panda_id           (panda_id)
#
require 'rails_helper'

RSpec.describe MucusRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
