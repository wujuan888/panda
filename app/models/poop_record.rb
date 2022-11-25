# == Schema Information
#
# Table name: poop_records
#
#  id                  :bigint           not null, primary key
#  color(大便颜色)     :string(30)
#  element(大便成分)   :string(50)
#  quality(大便质量)   :string(20)
#  texture(大便质地)   :string(50)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_poop_records_on_feeding_record_id  (feeding_record_id)
#  index_poop_records_on_panda_id           (panda_id)
#
class PoopRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
end
