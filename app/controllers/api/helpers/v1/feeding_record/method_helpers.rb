# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module FeedingRecord
        module MethodHelpers
          extend Grape::API::Helpers

          def create_param(params)
            feeding_record = base_create(params)
            other_params = {}
            other_params = eat_other_records_update(params[:eat_other_records_attributes], feeding_record, other_params)
            other_params = drug_records_update(params[:drug_records_attributes], feeding_record, other_params)
            other_params = train_records_update(params[:train_records_attributes], feeding_record, other_params)
            other_params = states_records_update(params[:states_records_attributes], feeding_record, other_params)
            feeding_record.update(other_params)
            image_list_create(params[:image_list], feeding_record)
            feeding_record.panda.states_update
            feeding_record.panda
          end

          def update_param(params, feeding_record)
            base_update(params, feeding_record)
            other_params = {}
            other_params = eat_other_records_update(params[:eat_other_records_attributes], feeding_record, other_params)
            other_params = drug_records_update(params[:drug_records_attributes], feeding_record, other_params)
            other_params = train_records_update(params[:train_records_attributes], feeding_record, other_params)
            other_params = states_records_update(params[:states_records_attributes], feeding_record, other_params)
            feeding_record.update(other_params)
            image_list_update(params[:image_list], feeding_record)
            feeding_record.panda.states_update
            feeding_record.panda
          end

          def you_create_param(params)
            feeding_record = you_base_create(params)
            other_params = {}
            other_params = drug_records_update(params[:drug_records_attributes], feeding_record, other_params)
            other_params = states_records_update(params[:states_records_attributes], feeding_record, other_params)
            feeding_record.update(other_params)
            image_list_create(params[:image_list], feeding_record)
            feeding_record.panda.states_update
            feeding_record.panda
          end

          def you_update_param(params, feeding_record)
            base_update(params, feeding_record)
            other_params = {}
            other_params = drug_records_update(params[:drug_records_attributes], feeding_record, other_params)
            other_params = states_records_update(params[:states_records_attributes], feeding_record, other_params)
            feeding_record.update(other_params)
            image_list_update(params[:image_list], feeding_record)
            feeding_record.panda.states_update
            feeding_record.panda
          end

          def image_list_create(image_list, feeding_record)
            return if image_list.blank?

            image_list.each do |image|
              ::Attachment.create(item_id: feeding_record.id, item_type: 'FeedingRecord', url: image)
            end
          end

          def image_list_update(image_list, feeding_record)
            old_list = ::Attachment.with_item(feeding_record.id, item_type: 'FeedingRecord').pluck('url')
            image_list = [] if image_list.blank?
            delete_list = old_list - image_list
            new_list = image_list - old_list
            ::Attachment.with_item(feeding_record.id, item_type: 'FeedingRecord', url: delete_list).delete_all if delete_list.present?
            image_list_create(new_list, feeding_record)
          end

          def eat_other_records_update(params, feeding_record, other_params)
            items = json_array_to_hash_array(params)
            old_ids = feeding_record.eat_other_records.pluck('id')
            now_ids = items.map { |x| x&.id }
            delete_ids = old_ids - now_ids
            ::EatOtherRecord.with_id(delete_ids).destroy_all if delete_ids.present?
            other_params[:eat_other_records_attributes] = items
            other_params[:eat_other_records_attributes][:panda_id] = feeding_record.panda_id
            other_params
          end

          def drug_records_update(params, feeding_record, other_params)
            items = json_array_to_hash_array(params)
            old_ids = feeding_record.drug_records.pluck('id')
            now_ids = items.map { |x| x&.id }
            delete_ids = old_ids - now_ids
            ::DrugRecord.with_id(delete_ids).destroy_all if delete_ids.present?
            other_params[:drug_records_attributes] = items
            other_params[:drug_records_attributes][:panda_id] = feeding_record.panda_id
            other_params
          end

          def train_records_update(params, feeding_record, other_params)
            items = json_array_to_hash_array(params)
            old_ids = feeding_record.train_records.pluck('id')
            now_ids = items.map { |x| x&.id }
            delete_ids = old_ids - now_ids
            ::TrainRecord.with_id(delete_ids).destroy_all if delete_ids.present?
            other_params[:train_records_attributes] = items
            other_params[:train_records_attributes][:panda_id] = feeding_record.panda_id
            other_params
          end

          def states_records_update(params, feeding_record, other_params)
            items = json_array_to_hash_array(params)
            old_ids = feeding_record.states_records.pluck('id')
            now_ids = items.map { |x| x&.id }
            delete_ids = old_ids - now_ids
            ::StatesRecord.with_id(delete_ids).destroy_all if delete_ids.present?
            other_params[:states_records_attributes] = items
            other_params[:states_records_attributes][:panda_id] = feeding_record.panda_id
            other_params
          end

          def json_array_to_hash_array(params)
            data = []
            params&.each do |item|
              data.push(JSON.parse(item))
            end
            data
          end

          def base_create(params)
            base_params = params
            base_params[:feeding_type] = 0
            base_params[:user_id] = current_user.id
            base_params.delete(:eat_other_records_attributes)
            base_params.delete(:drug_records_attributes)
            base_params.delete(:train_records_attributes)
            base_params.delete(:states_records_attributes)
            base_params.delete(:image_list)
            date_record = params[:time].delete('-')
            feeding_record = ::FeedingRecord.with_panda_record(params[:panda_id], date_record)&.last
            if feeding_record.blank?
              feeding_record = ::FeedingRecord.create(base_params)
            else
              feeding_record.update(base_params)
            end
            feeding_record
          end

          def you_base_create(params)
            base_params = params
            base_params[:feeding_type] = 1
            base_params[:user_id] = current_user.id
            base_params.delete(:drug_records_attributes)
            base_params.delete(:states_records_attributes)
            base_params.delete(:image_list)
            ::FeedingRecord.create(base_params)
          end

          def you_base_update(params)
            base_params = params
            base_params[:feeding_type] = 0
            base_params.delete(:drug_records_attributes)
            base_params.delete(:states_records_attributes)
            base_params.delete(:image_list)
            feeding_record.update(base_params)
          end

          def base_update(params, feeding_record)
            base_params = params
            base_params.delete(:eat_other_records_attributes)
            base_params.delete(:drug_records_attributes)
            base_params.delete(:train_records_attributes)
            base_params.delete(:states_records_attributes)
            base_params.delete(:image_list)
            feeding_record.update(base_params)
          end

        end
      end
    end
  end
end