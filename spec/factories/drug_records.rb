# == Schema Information
#
# Table name: drug_records
#
#  id                             :bigint           not null, primary key
#  dose(剂量)                     :string(50)
#  drugs(药物)                    :string(500)
#  other(其它)                    :string(200)
#  remark(备注)                   :string(300)
#  time(时间)                     :datetime
#  time_record(喂药时间（12:00）) :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  drug_id                        :integer          default(0)
#  panda_id(熊猫)                 :integer
#  user_id(开药人)                :integer
#
# Indexes
#
#  index_drug_records_on_panda_id  (panda_id)
#  index_drug_records_on_user_id   (user_id)
#
FactoryBot.define do
  factory :drug_record do
    
  end
end
