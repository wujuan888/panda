# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class ShowData < Grape::Entity
        expose :id, :weight, :panda_id, :remark, :feeding_type
        expose :created_at, format_with: :localtime
        expose :time, format_with: :only_date
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :eat_record, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::EatRecord::Data.represent instance.eat_record
        end
        expose :eat_other_records, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::EatOtherRecord::Data.represent instance.eat_other_records
        end
        expose :behavior_record, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::BehaviorRecord.represent instance.behavior_record
        end
        expose :train_records, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::TrainRecord::Data.represent instance.train_records
        end
        expose :enrichment_record, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::EnrichmentRecord::Data.represent instance.enrichment_record
        end
        expose :drug_records do |instance, _|
          Entities::DrugRecord::Data.represent instance.drug_records
        end
        expose :mucus_record, if: ->(instance, _) { instance.feeding_type.zero? } do |instance, _|
          Entities::MucusRecord::Data.represent instance.mucus_record
        end
        expose :milk_record, if: ->(instance, _) { instance.feeding_type == 1 } do |instance, _|
          Entities::MilkRecord::Data.represent instance.milk_record
        end
        expose :temperature_record, if: ->(instance, _) { instance.feeding_type == 1 } do |instance, _|
          Entities::TemperatureRecord.represent instance.temperature_record
        end
        expose :poop_record do |instance, _|
          Entities::PoopRecord::Data.represent instance.poop_record
        end
        expose :com_evaluation_record do |instance, _|
          Entities::ComEvaluationRecord::Data.represent instance.com_evaluation_record
        end
        expose :states_records do |instance, _|
          Entities::StatesRecord::Data.represent instance.states_records
        end
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end

      end
    end
  end
end
