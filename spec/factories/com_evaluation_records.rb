# == Schema Information
#
# Table name: com_evaluation_records
#
#  id                   :bigint           not null, primary key
#  collection(采集情况) :string(100)
#  other(其它情况)      :string(100)
#  spiritual(精神情况)  :string(100)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  feeding_record_id    :integer
#  panda_id             :integer
#
# Indexes
#
#  index_com_evaluation_records_on_feeding_record_id  (feeding_record_id)
#  index_com_evaluation_records_on_panda_id           (panda_id)
#
FactoryBot.define do
  factory :com_evaluation_record do
    
  end
end
