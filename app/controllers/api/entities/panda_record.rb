# frozen_string_literal: true

module Api
  module Entities
    class PandaRecord < Grape::Entity
      expose :count, :f_count, :ill_count, :lease_count, :m_count, :pregnant_count
    end
  end
end
