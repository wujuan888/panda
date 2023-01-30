# == Schema Information
#
# Table name: drug_records
#
#  id                             :bigint           not null, primary key
#  dose(剂量)                     :string(50)
#  drugs(药物)                    :string(500)
#  other(其它)                    :string(200)
#  remark(备注)                   :string(300)
#  time(时间)                     :datetime
#  time_record(喂药时间（12:00）) :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  drug_id                        :integer          default(0)
#  feeding_record_id              :integer
#  panda_id(熊猫)                 :integer
#  user_id(开药人)                :integer
#
# Indexes
#
#  index_drug_records_on_feeding_record_id  (feeding_record_id)
#  index_drug_records_on_panda_id           (panda_id)
#  index_drug_records_on_user_id            (user_id)
#
class DrugRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record

  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }

  scope :with_id, ->(ids) { where(id: ids) }
  scope :with_start_stop_date, ->(start, stop) { where('time >= ? and time <= ?', start, Date.parse(stop) + 1.day) }
end
