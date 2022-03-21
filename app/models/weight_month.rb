# == Schema Information
#
# Table name: weight_months
#
#  id             :bigint           not null, primary key
#  add(增长体重)  :string(10)
#  date(日期)     :datetime
#  weight(体重)   :string(10)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  panda_id(熊猫) :integer
#
class WeightMonth < ApplicationRecord
  belongs_to :panda
end
