Rails.application.routes.draw do
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :applicants do 
    collection do
      post :calculate_inss
    end
  end

  namespace :reports do
    resources :applicants, only: [:index]
    namespace :applicants do
      get 'salary'
    end
  end
  
  root "applicants#index"
end
