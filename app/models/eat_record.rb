# == Schema Information
#
# Table name: eat_records
#
#  id                  :bigint           not null, primary key
#  amount              :string(20)
#  is_input(是否录入)  :boolean          default(FALSE)
#  name                :string(100)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_eat_records_on_feeding_record_id  (feeding_record_id)
#  index_eat_records_on_panda_id           (panda_id)
#
class EatRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record

  after_create :create_item

  def create_item
    is_input = name.present? || feeding_record.eat_other_records.present?
    update_columns(is_input: is_input)
  end
end
