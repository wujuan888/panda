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
class ComEvaluationRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record

  after_create :create_item

  def create_item
    is_input = collection.present? || spiritual.present? || other.present?
    update_columns(is_input: is_input)
  end
end
