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
class Dormitory < ApplicationRecord
  belongs_to :place
  belongs_to :district
  has_many :pandas
  has_many :rooms
  has_many :dormitory_records

  scope :with_name, ->(name) { where(name: name, is_delete: false) }
  scope :with_district, ->(id) { where(district_id: id, is_delete: false) }
  scope :with_place, ->(id) { where(place_id: id, is_delete: false) }
  scope :with_delete, ->(is_delete) { where(is_delete: is_delete) }

  after_commit :change_item

  def change_item
    update_columns(panda_count: pandas.count)
  end
end
