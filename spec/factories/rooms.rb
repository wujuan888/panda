# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  is_delete(删除) :boolean          default(FALSE)
#  name            :string(500)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  district_id     :integer
#  dormitory_id    :integer
#  place_id        :integer
#  user_id         :integer
#
# Indexes
#
#  index_rooms_on_name  (name)
#  place                (place_id,district_id,dormitory_id)
#
FactoryBot.define do
  factory :room do
    
  end
end
