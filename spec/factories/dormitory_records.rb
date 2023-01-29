# == Schema Information
#
# Table name: dormitory_records
#
#  id              :bigint           not null, primary key
#  address(地址)   :string(20)
#  name            :string(30)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dormitory_id    :integer
#  panda_id(地址)  :integer
#  room_id         :integer          default(0)
#  user_id(负责人) :integer
#
# Indexes
#
#  index_dormitory_records_on_dormitory_id  (dormitory_id)
#  index_dormitory_records_on_panda_id      (panda_id)
#
FactoryBot.define do
  factory :dormitory_record do
    
  end
end
