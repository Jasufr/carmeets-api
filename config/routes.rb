Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :meetings, only: [ :index ]
    end
  end
  root to: "pages#home"
end
