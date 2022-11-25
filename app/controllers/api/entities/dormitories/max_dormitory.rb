# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class MaxDormitory < Grape::Entity
        expose :id, :name, :address, :remark

      end
    end
  end
end
