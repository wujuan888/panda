# == Schema Information
#
# Table name: weight_records
#
#  id                  :bigint           not null, primary key
#  daily_gain(日增重)  :string(10)
#  date(日期)          :datetime
#  feed_intake(采食量) :string(10)
#  feed_ratio(采食比)  :string(10)
#  other(其它)         :string(100)
#  weight(体重)        :string(10)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  panda_id(熊猫)      :integer
#  user_id(记录人)     :integer
#
# Indexes
#
#  index_weight_records_on_panda_id  (panda_id)
#  index_weight_records_on_user_id   (user_id)
#
class WeightRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :user
  has_many :attachments, as: :item
end
