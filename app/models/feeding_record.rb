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
class FeedingRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :user
  has_many :attachments, as: :item
  # 竹类投喂情况
  has_one :eat_record
  # 其他投喂情况
  has_many :eat_other_records
  # 粪便情况
  has_one :poop_record
  # 粘液情况
  has_one :mucus_record
  # 喂药情况
  has_many :drug_records
  # 丰容情况
  has_one :enrichment_record
  # 训练情况
  has_many :train_records
  # 行为情况
  has_one :behavior_record
  # 综合评估
  has_one :com_evaluation_record
  # 奶量
  has_one :milk_record
  # 体温、温箱
  has_one :temperature_record
  # 特殊状态
  has_many :states_records

  accepts_nested_attributes_for :eat_record
  accepts_nested_attributes_for :eat_other_records
  accepts_nested_attributes_for :poop_record
  accepts_nested_attributes_for :mucus_record
  accepts_nested_attributes_for :drug_records
  accepts_nested_attributes_for :enrichment_record
  accepts_nested_attributes_for :train_records
  accepts_nested_attributes_for :behavior_record
  accepts_nested_attributes_for :com_evaluation_record
  accepts_nested_attributes_for :states_records
  accepts_nested_attributes_for :temperature_record
  accepts_nested_attributes_for :milk_record

  after_create :create_item

  def create_item
    if feeding_type.zero?
      EatRecord.create(panda_id: panda_id, feeding_record_id: id) if eat_record.blank?
      MucusRecord.create(panda_id: panda_id, feeding_record_id: id) if mucus_record.blank?
      EnrichmentRecord.create(panda_id: panda_id, feeding_record_id: id) if enrichment_record.blank?
      BehaviorRecord.create(panda_id: panda_id, feeding_record_id: id) if behavior_record.blank?
    else
      MilkRecord.create(panda_id: panda_id, feeding_record_id: id) if milk_record.blank?
      TemperatureRecord.create(panda_id: panda_id, feeding_record_id: id) if temperature_record.blank?
    end
    PoopRecord.create(panda_id: panda_id, feeding_record_id: id) if poop_record.blank?
    ComEvaluationRecord.create(panda_id: panda_id, feeding_record_id: id) if com_evaluation_record.blank?
    update_columns(date_record: time.strftime('%Y%m%d').to_i)
  end

  def daily_add_weight
    return if feeding_type.zero?

    pre_item = FeedingRecord.with_panda_type(panda_id, 1).with_date_record_pre(date_record)
    return if pre_item.weight.blank? || weight.blank?

    add_w = weight - pre_item.weight
    day_count = (time - pre_item.time)
  end

  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }
  scope :with_panda_type, ->(panda_id, type) { where(panda_id: panda_id, feeding_type: type) }
  scope :with_date_record, ->(date_record) { where(date_record: date_record) }
  scope :with_date_record_pre, ->(date_record) { where('date_record < ?', date_record)&.last }
  scope :with_panda_record, ->(panda_id, date_record) { where(panda_id: panda_id, date_record: date_record) }
  scope :with_start_stop_date, ->(start, stop) { where('date_record >= ? and date_record <= ?', start, stop) }
end
