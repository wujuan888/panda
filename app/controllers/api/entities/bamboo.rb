# frozen_string_literal: true

module Api
  module Entities
    module Bamboo
      class MaxData < Grape::Entity
        expose :name, :id
      end

      class Data < Grape::Entity
        expose :name
      end
    end
  end
end
