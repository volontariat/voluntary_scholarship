Rails.application.routes.draw do
  get '/products/scholarship' => 'product/scholarship#index', as: 'scholarship_product'
  
  namespace :scholarship do
    resources :programs do
      resources :iterations, only: [:index, :new]
    end
    
    resources :teams do
      resources :members, controller: 'team_memberships', only: [:index, :new]
    end
    
    resources :team_memberships, only: [:create, :edit, :update, :destroy]
    
    resources :iterations, only: [:create, :show, :edit, :update, :destroy]
  end
  
  resources :organizations do
    namespace :scholarship do
      resources :programs, only: [:index, :new]
    end
  end
end
