# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module FeedingRecord
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '饲养ID'
          end

          params :uuid_time_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: String, desc: '熊猫ID'
            requires :date, type: String, desc: '日期'
          end

          params :uuid_panda_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫ID'
          end

          params :uuid_panda_date_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫ID'
            requires :start_date, type: String, desc: '起始日期'
            requires :stop_date, type: String, desc: '截止日期'
          end

          params :create_params do
            use :base_params
            optional :eat_record_attributes, type: Hash, desc: '投食' do
              use :eat_params
            end
            optional :eat_other_records_attributes, type: Array[JSON], desc: '投食(其他)' do
              use :eat_params
            end
            optional :poop_record_attributes, type: Hash, desc: '粪便情况' do
              use :poop_params
            end
            optional :mucus_record_attributes, type: Hash, desc: '粘液情况' do
              optional :time_record, type: String, desc: '排粘时间'
            end
            optional :drug_records_attributes, type: Array[JSON], desc: '喂药情况' do
              use :drug_params
            end
            optional :enrichment_record_attributes, type: Hash, desc: '丰容情况' do
              optional :name, type: String, desc: '名称'
            end
            optional :train_records_attributes, type: Array[JSON], desc: '训练情况' do
              use :train_params
            end
            optional :behavior_record_attributes, type: Hash, desc: '行为情况' do
              optional :name, type: String, desc: '名称'
            end
            optional :com_evaluation_record_attributes, type: Hash, desc: '综合评估' do
              use :com_evaluation_params
            end
            optional :states_records_attributes, type: Array[JSON], desc: '特殊状态' do
              use :states_params
            end
          end

          params :base_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫'
            requires :weight, type: String, desc: '体重'
            optional :remark, type: String, desc: '备注'
            requires :time, type: String, desc: '日期'
            optional :image_list, type: Array[String], desc: '照片url'
          end

          params :eat_params do
            optional :name, type: String, desc: '名称'
            optional :amount, type: String, desc: '数量'
          end

          params :poop_params do
            optional :texture, type: String, desc: '大便质地'
            optional :element, type: String, desc: '大便成分'
            optional :color, type: String, desc: '大便颜色'
            optional :quality, type: String, desc: '大便质量'
          end

          params :train_params do
            optional :name, type: String, desc: '名称'
            optional :result, type: String, desc: '结果'
          end

          params :drug_params do
            optional :drug_id, type: Integer, desc: '药品id'
            optional :dose, type: String, desc: '剂量'
            optional :time_record, type: String, desc: '喂药时间 : 12:00'
          end

          params :com_evaluation_params do
            optional :collection, type: String, desc: '采集情况'
            optional :spiritual, type: String, desc: '精神情况'
            optional :other, type: String, desc: '其它情况'
          end

          params :states_params do
            optional :item_id, type: Integer, desc: '结束状态的开始id'
            optional :states_type, type: Integer, desc: '0: 开始, 1: 结束'
            optional :name, type: String, desc: '名称'
            optional :date, type: String, desc: '开始或结束时间'
            optional :district, type: String, desc: '地区'
            optional :institution, type: String, desc: '机构'
          end

          params :milk_params do
            optional :artificial_milk, type: String, desc: '人工奶'
            optional :breast_milk, type: String, desc: '母乳处奶量'
            optional :su_breast_milk, type: String, desc: '补母乳'
            optional :milks, type: String, desc: '总奶量'
          end

          params :temperature_params do
            optional :body, type: String, desc: '体温'
            optional :box, type: String, desc: '箱温'
          end

          params :update_params do
            requires :id, type: Integer, desc: '饲养ID'
            use :base_params
            optional :eat_record_attributes, type: Hash, desc: '投食' do
              optional :id, type: Integer, desc: 'eat_record ID'
              use :eat_params
            end
            optional :eat_other_records_attributes, type: Array[JSON], desc: '投食(其他)' do
              optional :id, type: Integer, desc: 'eat_other_record ID'
              use :eat_params
            end
            optional :poop_record_attributes, type: Hash, desc: '粪便情况' do
              optional :id, type: Integer, desc: 'poop_record ID'
              use :poop_params
            end
            optional :mucus_record_attributes, type: Hash, desc: '粘液情况' do
              optional :id, type: Integer, desc: 'mucus_record ID'
              optional :time_record, type: String, desc: '排粘时间'
            end
            optional :drug_records_attributes, type: Array[JSON], desc: '喂药情况' do
              optional :id, type: Integer, desc: 'drug_record ID'
              use :drug_params
            end
            optional :enrichment_record_attributes, type: Hash, desc: '丰容情况' do
              optional :id, type: Integer, desc: 'enrichment_record ID'
              optional :name, type: String, desc: '名称'
            end
            optional :train_records_attributes, type: Array[JSON], desc: '训练情况' do
              optional :id, type: Integer, desc: 'train_records ID'
              use :train_params
            end
            optional :behavior_record_attributes, type: Hash, desc: '行为情况' do
              optional :id, type: Integer, desc: 'behavior_record ID'
              optional :name, type: String, desc: '名称'
            end
            optional :com_evaluation_record_attributes, type: Hash, desc: '综合评估' do
              optional :id, type: Integer, desc: 'com_evaluation_record ID'
              use :com_evaluation_params
            end
            optional :states_record_attributes, type: Array[JSON], desc: '特殊状态' do
              optional :id, type: Integer, desc: 'states_record ID'
              use :states_params
            end
          end


          params :you_create_params do
            use :base_params
            optional :milk_record_attributes, type: Hash, desc: '奶量' do
              use :milk_params
            end
            optional :poop_record_attributes, type: Hash, desc: '粪便情况' do
              use :poop_params
            end
            optional :temperature_record_attributes, type: Hash, desc: '箱温/体温' do
              use :temperature_params
            end
            optional :drug_records_attributes, type: Array[JSON], desc: '喂药情况' do
              use :drug_params
            end
            optional :com_evaluation_record_attributes, type: Hash, desc: '综合评估' do
              use :com_evaluation_params
            end
            optional :states_record_attributes, type: Array[JSON], desc: '特殊状态' do
              use :states_params
            end
          end

          params :you_update_params do
            requires :id, type: Integer, desc: '饲养ID'
            use :base_params
            optional :milk_record_attributes, type: Hash, desc: '奶量' do
              optional :id, type: Integer, desc: 'milk_record ID'
              use :milk_params
            end
            optional :poop_record_attributes, type: Hash, desc: '粪便情况' do
              optional :id, type: Integer, desc: 'poop_record ID'
              use :poop_params
            end
            optional :temperature_record_attributes, type: Hash, desc: '箱温/体温' do
              optional :id, type: Integer, desc: 'temperature_record ID'
              use :temperature_params
            end
            optional :drug_records_attributes, type: Array[JSON], desc: '喂药情况' do
              optional :id, type: Integer, desc: 'drug_record ID'
              use :drug_params
            end
            optional :com_evaluation_record_attributes, type: Hash, desc: '综合评估' do
              optional :id, type: Integer, desc: 'com_evaluation_record ID'
              use :com_evaluation_params
            end
            optional :states_record_attributes, type: Array[JSON], desc: '特殊状态' do
              optional :id, type: Integer, desc: 'states_record ID'
              use :states_params
            end
          end

        end
      end
    end
  end
end