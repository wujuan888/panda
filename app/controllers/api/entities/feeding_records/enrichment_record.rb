# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class EnrichmentRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :enrichment_record do |instance, _|
          Entities::EnrichmentRecord::Data.represent instance.enrichment_record
        end
      end
    end
  end
end
