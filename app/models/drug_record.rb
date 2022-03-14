# == Schema Information
#
# Table name: drug_records
#
#  id              :bigint           not null, primary key
#  date(日期)      :date
#  other(其它)     :string(200)
#  remark(备注)    :string(300)
#  time(时间)      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  panda_id(熊猫)  :integer
#  user_id(开药人) :integer
#
# Indexes
#
#  index_drug_records_on_panda_id  (panda_id)
#  index_drug_records_on_user_id   (user_id)
#
class DrugRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :user
  has_many :attachments, as: :item

  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }

  scope :with_start_stop_date, ->(start, stop) { where('time >= ? and time <= ?', start, Date.parse(stop) + 1.day) }
end
