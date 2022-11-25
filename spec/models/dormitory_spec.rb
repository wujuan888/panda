# == Schema Information
#
# Table name: dormitories
#
#  id                    :bigint           not null, primary key
#  address(地址)         :string(20)
#  name                  :string(30)
#  panda_count(熊猫数量) :integer          default(0)
#  remark(备注)          :string(200)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  district_id           :integer
#  place_id              :integer
#  user_id(负责人)       :integer
#
# Indexes
#
#  index_dormitories_on_name  (name)
#  place                      (place_id,district_id)
#
require 'rails_helper'

RSpec.describe Dormitory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
