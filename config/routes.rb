Rails.application.routes.draw do
  get '/products/scholarship' => 'product/scholarship#index', as: 'scholarship_product'
  
  namespace :scholarship do
    resources :programs do
      resources :iterations, only: [:index, :new]
    end
    
    resources :teams
    
    resources :iterations, only: [:create, :show, :edit, :update, :destroy]
  end
  
  resources :organizations do
    namespace :scholarship do
      resources :programs, only: [:index, :new]
    end
  end
end
