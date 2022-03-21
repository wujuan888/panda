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
require 'rails_helper'

RSpec.describe WeightMonth, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
