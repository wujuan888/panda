# == Schema Information
#
# Table name: weight_months
#
#  id             :bigint           not null, primary key
#  add(增长体重)  :string(10)
#  date(日期)     :datetime
#  init_weight    :string(255)
#  month(月)      :integer
#  weight(体重)   :string(10)
#  year(年)       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  panda_id(熊猫) :integer
#
# Indexes
#
#  index_weight_months_on_panda_id        (panda_id)
#  index_weight_months_on_year_and_month  (year,month)
#
class WeightMonth < ApplicationRecord
  belongs_to :panda

  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }

  scope :with_start_stop_date, ->(start, stop) { where('date >= ? and date <= ?', start, Date.parse(stop) + 1.day) }
end
