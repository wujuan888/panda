require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'
  mount Api::Base, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/doc'
end
