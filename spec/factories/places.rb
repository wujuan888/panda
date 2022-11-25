# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  name       :string(100)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_places_on_name  (name)
#
FactoryBot.define do
  factory :place do
    
  end
end
