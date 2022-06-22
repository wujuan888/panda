# == Schema Information
#
# Table name: bamboos
#
#  id         :bigint           not null, primary key
#  name       :string(30)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bamboo < ApplicationRecord
  scope :with_name, ->(name) { where(name: name) }
end
