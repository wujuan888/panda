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
class Room < ApplicationRecord
  belongs_to :place
  belongs_to :district
  belongs_to :dormitory
  has_many :pandas


  scope :with_delete, ->(is_delete) { where(is_delete: is_delete) }
  scope :with_place, ->(id) { where(place_id: id, is_delete: false) }
  scope :with_district, ->(id) { where(district_id: id, is_delete: false) }
  scope :with_dormitory, ->(id) { where(dormitory_id: id, is_delete: false) }
  scope :with_name, ->(name) { where(name: name, is_delete: false) }
end
