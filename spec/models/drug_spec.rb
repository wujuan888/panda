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
require 'rails_helper'

RSpec.describe Drug, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
