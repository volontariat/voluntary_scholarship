Rails.application.routes.draw do
  get '/products/scholarship' => 'product/scholarship#index', as: 'scholarship_product'
  
  namespace :scholarship do
    resources :programs
  end
  
  resources :organizations do
    namespace :scholarship do
      resources :programs, only: [:index, :new]
    end
  end
end
