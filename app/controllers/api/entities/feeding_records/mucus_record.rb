# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class MucusRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :mucus_record do |instance, _|
          Entities::MucusRecord::Data.represent instance.mucus_record
        end
      end
    end
  end
end
