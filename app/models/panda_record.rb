# == Schema Information
#
# Table name: panda_records
#
#  id                        :bigint           not null, primary key
#  count(熊猫总数量)         :integer          default(0)
#  dai_zai_count(带仔数量)   :integer          default(0)
#  f_count(雄性数量)         :integer          default(0)
#  fa_qin_count(发情数量)    :integer          default(0)
#  ill_count(生病数量)       :integer          default(0)
#  lease_count(租借数量)     :integer          default(0)
#  m_count(雌性数量)         :integer          default(0)
#  pei_zhong_count(配种数量) :integer          default(0)
#  pregnant_count(怀孕数量)  :integer          default(0)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  place_id                  :integer
#
class PandaRecord < ApplicationRecord
  belongs_to :place, required: false
  scope :with_place, ->(id) { where(place_id: id) }
end
