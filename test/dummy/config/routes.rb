Rails.application.routes.draw do
  mount Aypex::Api::Engine => "/aypex-api"
end
