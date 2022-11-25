# == Schema Information
#
# Table name: train_records
#
#  id                  :bigint           not null, primary key
#  name                :string(20)
#  result(训练结果)    :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  feeding_record_id   :integer
#  panda_id            :integer
#
# Indexes
#
#  index_train_records_on_feeding_record_id  (feeding_record_id)
#  index_train_records_on_panda_id           (panda_id)
#
require 'rails_helper'

RSpec.describe TrainRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
