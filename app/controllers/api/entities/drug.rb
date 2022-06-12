# frozen_string_literal: true

module Api
  module Entities
    module Drug
      class Data < Grape::Entity
        expose :name
      end

      class MaxData < Grape::Entity
        expose :name, :drug_type, :id
      end
    end
  end
end
