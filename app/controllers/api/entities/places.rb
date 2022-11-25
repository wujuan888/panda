# frozen_string_literal: true

module Api
  module Entities
    module Places
      class Place < Grape::Entity
        expose :id, :name
      end
    end
  end
end
