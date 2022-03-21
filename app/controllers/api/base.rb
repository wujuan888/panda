# frozen_string_literal: true

require 'grape_logging'

module Api
  class Base < Grape::API

    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, logger: logger

    Grape::Entity.format_with :timestamp do |date|
      date&.to_i
    end

    Grape::Entity.format_with :datetime do |date|
      date.present? ? date.strftime('%Y-%m-%d %H:%M') : nil
    end

    Grape::Entity.format_with :localtime do |date|
      date.present? ? date.localtime.strftime('%Y-%m-%d %H:%M') : nil
    end

    Grape::Entity.format_with :only_date do |date|
      date.present? ? date.strftime('%Y-%m-%d') : nil
    end

    mount V1::Mount

    add_swagger_documentation(
      info: {
        title: 'Eye See API Documentation',
        contact_email: 'luolinae86@gmail.com'
      },
      mount_path: '/doc/swagger',
      doc_version: '0.1.0'
    )
  end
end
