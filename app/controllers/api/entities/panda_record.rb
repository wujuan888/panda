# frozen_string_literal: true

module Api
  module Entities
    class PandaRecord < Grape::Entity
      expose :count, :f_count, :ill_count, :lease_count, :m_count, :pregnant_count
      expose :dai_zai_count, :fa_qin_count, :pei_zhong_count

    end
  end
end