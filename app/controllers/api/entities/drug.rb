# frozen_string_literal: true

module Api
  module Entities
    class Drug < Grape::Entity
      expose :name
    end
  end
end
