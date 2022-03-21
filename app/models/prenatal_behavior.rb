# == Schema Information
#
# Table name: prenatal_behaviors
#
#  id                        :bigint           not null, primary key
#  bamboo(竹子)              :string(30)
#  behavior_event(事件)      :string(50)
#  behavior_remark(行为备注) :string(100)
#  behavior_time(行为时间)   :datetime
#  poop(大便)                :string(30)
#  remark(备注)              :string(100)
#  time(时间)                :datetime
#  wo_tou(窝头)              :string(30)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  panda_id(熊猫)            :integer
#  user_id(记录人)           :integer
#
# Indexes
#
#  index_prenatal_behaviors_on_panda_id  (panda_id)
#  index_prenatal_behaviors_on_user_id   (user_id)
#
class PrenatalBehavior < ApplicationRecord
  belongs_to :panda
  belongs_to :user
  has_many :attachments, as: :item
  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }

  scope :with_start_stop_date, ->(start, stop) { where('behavior_time >= ? and behavior_time <= ?', start, Date.parse(stop) + 1.day) }
end
