# frozen_string_literal: true

module Api
  module Entities
    class Attachment < Grape::Entity
      expose :id, :url, :sm_url
    end
  end
end
