# frozen_string_literal: true

module Api
  module Entities
    module PoopRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :color
        expose :element
        expose :quality
        expose :texture
      end
    end
  end
end
