# == Schema Information
#
# Table name: drugs
#
#  id                            :bigint           not null, primary key
#  drug_type(0 药品  1 保健药品) :integer          default(0)
#  name                          :string(30)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
class Drug < ApplicationRecord
  scope :with_type, ->(drug_type) { where(drug_type: drug_type) }
  scope :with_name_type, ->(name, drug_type) { where(name: name, drug_type: drug_type) }
end
