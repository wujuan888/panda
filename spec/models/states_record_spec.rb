# == Schema Information
#
# Table name: states_records
#
#  id                             :bigint           not null, primary key
#  date(开始或结束日期)           :datetime
#  date_record                    :integer
#  district(地区)                 :string(100)
#  institution(机构)              :string(100)
#  is_stop(是否结束)              :boolean          default(FALSE)
#  name                           :string(255)
#  states_type(0: 开始  1： 结束) :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  feeding_record_id              :integer
#  item_id(特殊状态开始或结束id)  :integer
#  panda_id                       :integer
#
# Indexes
#
#  index_states_records_on_feeding_record_id  (feeding_record_id)
#  index_states_records_on_panda_id           (panda_id)
#
require 'rails_helper'

RSpec.describe StatesRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
