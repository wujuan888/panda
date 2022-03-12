# frozen_string_literal: true

GrapeSwaggerRails.options.tap do |o|
  o.app_name       = 'Panda'
  o.url            = '/api/doc/swagger'
  o.app_url        = ''
  o.api_auth       = 'basic'
  o.api_key_name   = 'Authorization'
  o.api_key_type   = 'header'
  o.hide_url_input = true
  o.before_action do |_request|
    authenticate_or_request_with_http_basic do |username, password|
      username == 'isee' && password == 'isee'
    end
  end
end
