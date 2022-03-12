# frozen_string_literal: true

module Api
  module Entities
    module PrenatalBehaviors
      class MinPrenatalBehavior < Grape::Entity
        expose :id, :behavior_event
        expose :time, format_with: :datetime
      end
    end
  end
end
