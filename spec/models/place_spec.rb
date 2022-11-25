# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  name       :string(100)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_places_on_name  (name)
#
require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
