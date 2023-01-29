# == Schema Information
#
# Table name: temperature_records
#
#  id                  :bigint           not null, primary key
#  body(体温)          :string(20)
#  box(箱温)           :string(20)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_temperature_records_on_feeding_record_id  (feeding_record_id)
#  index_temperature_records_on_panda_id           (panda_id)
#
class TemperatureRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record

  after_create :create_item

  def create_item
    is_input = body.present? || box.present?
    update_columns(is_input: is_input)
  end
end
