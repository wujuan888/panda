# == Schema Information
#
# Table name: milk_records
#
#  id                      :bigint           not null, primary key
#  artificial_milk(人工奶) :string(20)
#  breast_milk(母乳处奶量) :string(20)
#  milks(总奶量)           :string(20)
#  su_breast_milk(补母乳)  :string(20)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  feeding_record_id       :integer
#  panda_id                :integer
#
# Indexes
#
#  index_milk_records_on_feeding_record_id  (feeding_record_id)
#  index_milk_records_on_panda_id           (panda_id)
#
class MilkRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :feeding_record
  after_create :create_item

  def create_item
    update_columns(is_input: milks.present?)
  end
end
