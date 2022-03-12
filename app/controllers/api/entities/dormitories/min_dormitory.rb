# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class MinDormitory < Grape::Entity
        expose :id, :name, :panda_count
      end
    end
  end
end
