# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module WeightRecord
        module MethodHelpers
          extend Grape::API::Helpers

          def weight_year_list(list)
            data = list.order('date asc').pluck('year', 'month', 'weight', 'add')
            date_list = {}
            data.each do |item|
              if date_list.include? item[0].to_s
                date_list[item[0].to_s][:date_list].push "#{item[1]}月"
                date_list[item[0].to_s][:weight_list].push item[2].to_s
                date_list[item[0].to_s][:add_list].push item[3].to_s
              else
                date_list[item[0].to_s] = { date_list: ["#{item[1]}月"], weight_list: [item[2].to_s], add_list: [item[3].to_s] }
              end
            end
            weight_list(date_list)
          end

          def weight_list(date_list)
            result = { date_list: [], weight_list: [], add_list: [] }
            index = 0
            date_list.each do |key, value|
              if index.zero?
                result = value
              else
                result[:date_list].push key
                result[:weight_list].push ''
                result[:add_list].push ''
                result[:date_list] += value[:date_list]
                result[:weight_list] += value[:weight_list]
                result[:add_list] += value[:add_list]
              end
              index += 1
            end
            result
          end

        end
      end
    end
  end
end