# == Schema Information
#
# Table name: weight_records
#
#  id                  :bigint           not null, primary key
#  daily_gain(日增重)  :string(10)
#  date(日期)          :datetime
#  feed_intake(采食量) :string(10)
#  feed_ratio(采食比)  :string(10)
#  other(其它)         :string(100)
#  weight(体重)        :string(10)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  panda_id(熊猫)      :integer
#  user_id(记录人)     :integer
#
# Indexes
#
#  index_weight_records_on_panda_id  (panda_id)
#  index_weight_records_on_user_id   (user_id)
#
class WeightRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :user
  has_many :attachments, as: :item
  after_create :create_item

  def create_item
    panda.update_columns(initial_weight: weight)
    weight_month = WeightMonth.where(year: time.year, month: time.month)&.last
    if weight_month.blank?
      pre_month = time - 1.month
      pre = WeightMonth.where(year: pre_month.year, month: pre_month.month)&.last
      init_weight = weight
      init_weight = pre.weight if pre.present?
      if weight_month.blank?
        WeightMonth.create(date: "#{time.year}-#{time.month}-01", year: time.year, month: time.month,
                            init_weight: init_weight, weight: weight_month, add: (weight.to_f - init_weight.to_f).round(2),
                            panda_id: panda_id)
      else
        weight_month.update(weight: weight, add: (weight.to_f - weight_month.init_weight.to_f).round(2))
      end
    end
  end

  scope :with_panda, ->(panda_id) { where(panda_id: panda_id) }

  scope :with_start_stop_date, ->(start, stop) { where('time >= ? and time <= ?', start, Date.parse(stop) + 1.day) }
end
