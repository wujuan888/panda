# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class TrainRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :train_records do |instance, _|
          Entities::TrainRecord::Data.represent instance.train_records
        end
      end
    end
  end
end
