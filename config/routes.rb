Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :meetings, only: [:index, :show, :update, :create, :destroy] do
        resources :comments, only: [:create, :update]
      end
    end
  end
  root to: "pages#home"
end
