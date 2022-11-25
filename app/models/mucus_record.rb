# == Schema Information
#
# Table name: mucus_records
#
#  id                  :bigint           not null, primary key
#  color(粘液颜色)     :string(20)
#  pain(粘液痛感)      :string(30)
#  quality(粘液质量)   :string(10)
#  record_date         :datetime
#  texture(粘液质地)   :string(30)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_mucus_records_on_feeding_record_id  (feeding_record_id)
#  index_mucus_records_on_panda_id           (panda_id)
#
class MucusRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
end
