# frozen_string_literal: true

module Api
  module Entities
    module MucusRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :time_record
      end
    end
  end
end
