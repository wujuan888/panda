# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class MaxYouRecord < Grape::Entity
        expose :id, :weight, :panda_id, :remark, :user_id
        expose :created_at, format_with: :localtime
        expose :time, format_with: :only_date
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :milk_record do |instance, _|
          Entities::MilkRecord::Data.represent instance.milk_record
        end
        expose :temperature_record do |instance, _|
          Entities::TemperatureRecord::Data.represent instance.temperature_record
        end
        expose :drug_records do |instance, _|
          Entities::DrugRecord::Data.represent instance.drug_records
        end
        expose :poop_record do |instance, _|
          Entities::PoopRecord::Data.represent instance.poop_record
        end
        expose :com_evaluation_record do |instance, _|
          Entities::ComEvaluationRecord::Data.represent instance.com_evaluation_record
        end
        expose :states_records do |instance, _|
          Entities::StatesRecord::MaxData.represent instance.states_records
        end
        expose :panda_states_records do |instance, _|
          Entities::StatesRecord::Data.represent ::StatesRecord.with_panda_current(instance.panda_id).with_not_feed(instance.id)
        end
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
        expose :drug_list do |_|
          Entities::Drug::MaxData.represent ::Drug.all
        end
        expose :bamboo_list do |_|
          Entities::Bamboo::Data.represent ::Bamboo.all
        end
      end
    end
  end
end
