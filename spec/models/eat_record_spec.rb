# == Schema Information
#
# Table name: eat_records
#
#  id                :bigint           not null, primary key
#  amount            :string(20)
#  name              :string(100)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  feeding_record_id :integer
#  panda_id          :integer
#
# Indexes
#
#  index_eat_records_on_feeding_record_id  (feeding_record_id)
#  index_eat_records_on_panda_id           (panda_id)
#
require 'rails_helper'

RSpec.describe EatRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
