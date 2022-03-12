# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  item_type  :string(30)
#  sm_url     :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#  panda_id   :integer
#
# Indexes
#
#  index_attachments_on_item_id_and_item_type  (item_id,item_type)
#  index_attachments_on_panda_id               (panda_id)
#
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
