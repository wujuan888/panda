# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class NewRecord < Grape::Entity
        expose :id, :weight, :panda_id, :remark
        expose :created_at, format_with: :localtime
        expose :time, format_with: :only_date
        expose :panda do |instance, option|
          Entities::Pandas::BasePanda.represent ::Panda.find(option[:panda_id])
        end
        expose :eat_record do |instance, _|
          Entities::EatRecord::Data.represent ::EatRecord.new
        end
        expose :behavior_record do |instance, _|
          Entities::BehaviorRecord::Data.represent ::BehaviorRecord.new
        end
        expose :enrichment_record do |instance, _|
          Entities::EnrichmentRecord::Data.represent ::EnrichmentRecord.new
        end
        expose :mucus_record do |instance, _|
          Entities::MucusRecord::Data.represent ::MucusRecord.new
        end
        expose :poop_record do |instance, _|
          Entities::PoopRecord::Data.represent ::PoopRecord.new
        end
        expose :com_evaluation_record do |instance, _|
          Entities::ComEvaluationRecord::Data.represent ::ComEvaluationRecord.new
        end
        expose :panda_states_records do |instance, option|
          Entities::StatesRecord::Data.represent ::StatesRecord.with_panda_current(option[:panda_id])
        end
        expose :drug_list do |_|
          Entities::Drug::Data.represent ::Drug.all
        end
        expose :bamboo_list do |_|
          Entities::Bamboo::Data.represent ::Bamboo.all
        end
      end
    end
  end
end
