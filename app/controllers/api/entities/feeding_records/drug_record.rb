# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class DrugRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :drug_records do |instance, _|
          Entities::DrugRecord::Data.represent instance.drug_records
        end
      end
    end
  end
end
