# frozen_string_literal: true

module Api
  module Entities
    module EnrichmentRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :name
      end
    end
  end
end
