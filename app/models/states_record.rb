# == Schema Information
#
# Table name: states_records
#
#  id                  :bigint           not null, primary key
#  district(地区)      :string(100)
#  institution(机构)   :string(100)
#  is_stop(是否结束)   :boolean          default(FALSE)
#  name                :string(255)
#  start_date          :date
#  stop_date           :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_states_records_on_feeding_record_id  (feeding_record_id)
#  index_states_records_on_panda_id           (panda_id)
#
class StatesRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
end
