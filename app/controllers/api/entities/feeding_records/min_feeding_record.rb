# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class MinFeedingRecord < Grape::Entity
        expose :id, :evaluation
        expose :time, format_with: :localtime
      end
    end
  end
end
