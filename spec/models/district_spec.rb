# == Schema Information
#
# Table name: districts
#
#  id              :bigint           not null, primary key
#  is_delete(删除) :boolean          default(FALSE)
#  name            :string(100)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  place_id        :integer
#  user_id         :integer
#
# Indexes
#
#  index_districts_on_name      (name)
#  index_districts_on_place_id  (place_id)
#
require 'rails_helper'

RSpec.describe District, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
