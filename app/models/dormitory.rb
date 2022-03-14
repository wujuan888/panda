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
#  user_id(负责人)       :integer
#
# Indexes
#
#  index_dormitories_on_name  (name)
#
class Dormitory < ApplicationRecord
  belongs_to :user
  has_many :pandas
  has_many :dormitory_records
  scope :with_name, ->(name) { where(name: name) }
end
