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
require 'rails_helper'

RSpec.describe TemperatureRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
