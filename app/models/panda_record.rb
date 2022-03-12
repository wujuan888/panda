# == Schema Information
#
# Table name: panda_records
#
#  id                       :bigint           not null, primary key
#  count(熊猫总数量)        :integer          default(0)
#  f_count(雄性数量)        :integer          default(0)
#  ill_count(生病数量)      :integer          default(0)
#  lease_count(租借数量)    :integer          default(0)
#  m_count(雌性数量)        :integer          default(0)
#  pregnant_count(怀孕数量) :integer          default(0)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class PandaRecord < ApplicationRecord
  belongs_to :panda
  belongs_to :user
end
