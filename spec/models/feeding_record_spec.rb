# == Schema Information
#
# Table name: feeding_records
#
#  id                               :bigint           not null, primary key
#  Health_medicine(保健药品)        :text(65535)
#  apple_ingest(苹果食入)           :string(10)
#  apple_input(苹果投给)            :string(10)
#  bamboo_ingest(竹子食入)          :string(10)
#  bamboo_input(竹子投给)           :string(10)
#  bamboo_part(竹子部位)            :string(20)
#  bamboo_variety(竹子品种)         :string(50)
#  collection(采集情况)             :string(100)
#  date_record(日期)                :integer
#  evaluation(综合评估)             :string(200)
#  feeding_type(类型 1 育幼 0 饲养) :integer          default(0)
#  forage_time(采食时间)            :string(10)
#  mucus_pain(粘液痛感)             :string(30)
#  mucus_quality(粘液质量)          :string(10)
#  mucus_texture(粘液质地)          :string(30)
#  mucus_time(粘液时间)             :string(10)
#  poop_color(大便颜色)             :string(20)
#  poop_element(大便成分)           :string(30)
#  poop_quality(大便质量)           :string(10)
#  poop_texture(大便质地)           :string(30)
#  remark(备注)                     :string(200)
#  spiritual(精神活动)              :string(100)
#  time(时间)                       :datetime
#  weight(体重)                     :string(100)
#  wo_tou_ingest(窝头食入)          :string(10)
#  wo_tou_input(窝头投给)           :string(10)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  panda_id(熊猫)                   :integer
#  user_id(记录人)                  :integer
#
# Indexes
#
#  index_feeding_records_on_panda_id  (panda_id)
#  index_feeding_records_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe FeedingRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
