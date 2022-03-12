# == Schema Information
#
# Table name: parenting_records
#
#  id                      :bigint           not null, primary key
#  Box_temperature(箱温)   :string(10)
#  artificial_milk(人工乳) :string(10)
#  breast_milk(母乳)       :string(10)
#  breathe(呼吸)           :string(10)
#  humidity(湿度)          :string(10)
#  mental_state(精神状态)  :string(100)
#  pee(小便)               :string(20)
#  poop(大便)              :string(20)
#  skin_temperature(肤温)  :string(10)
#  time(时间)              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  panda_id(熊猫)          :integer
#  user_id(记录人)         :integer
#
# Indexes
#
#  index_parenting_records_on_panda_id  (panda_id)
#  index_parenting_records_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe ParentingRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
