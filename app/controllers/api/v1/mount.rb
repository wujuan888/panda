# frozen_string_literal: true

require 'grape_logging'

module  Api
  module V1
    class Mount < Grape::API
      mount Api::V1::User
      mount Api::V1::Panda
      mount Api::V1::Dormitory
      mount Api::V1::DrugRecord
      mount Api::V1::FeedingRecord
      mount Api::V1::ParentingRecord
      mount Api::V1::PrenatalBehavior
      mount Api::V1::WeightRecord
      mount Api::V1::Bamboo
      mount Api::V1::Drug
    end
  end
end
