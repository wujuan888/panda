# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Panda
        module MethodHelpers
          extend Grape::API::Helpers

          def search_panda(params, pandas)
            pandas = pandas.where('name like ?', "%#{params[:name]}%") if params[:name].present?
            data = params.except(:uuid, :name)
            pandas = pandas.where(data) if data.present?
            pandas
          end
        end
      end
    end
  end
end