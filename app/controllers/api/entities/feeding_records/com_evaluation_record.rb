# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class ComEvaluationRecord < Grape::Entity
        expose :id
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :com_evaluation_record do |instance, _|
          Entities::ComEvaluationRecord::Data.represent instance.com_evaluation_record
        end
      end
    end
  end
end
