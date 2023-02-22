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
class StatesRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
  has_one :item_record, primary_key: :item_id, foreign_key: :id, class_name: 'StatesRecord'

  after_create :create_item
  after_destroy :destroy_item

  def create_item
    update_columns(date_record: feeding_record.date_record)
    item_record.update_columns(item_id: id, is_stop: true) if states_type == 1
    panda.update_columns(is_death: true) if states_type.zero? && name == '死亡'
  end

  def destroy_item
    item_record.update_columns(is_stop: false) if states_type == 1
    panda.update_columns(is_death: false) if states_type.zero? && name == '死亡'
  end

  scope :with_current, -> { where(is_stop: false, states_type: 0) }
  scope :with_panda_current, ->(panda_id) { where(panda_id: panda_id, is_stop: false, states_type: 0) }
  scope :with_id, ->(ids) { where(id: ids) }
  scope :with_not_feed, ->(id) { where.not(feeding_record_id: id) }
  scope :with_date_now, ->(date) { where('date_record < ?', date.strftime('%Y%m%d').to_i) }
end
