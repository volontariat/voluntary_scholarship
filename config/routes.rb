Rails.application.routes.draw do
  get '/products/scholarship' => 'product/scholarship#index', as: 'scholarship_product'
  
  namespace :scholarship do
    resources :programs do
      resources :iterations, only: [:index, :new]
    end
    
    resources :teams do
      resources :members, controller: 'team_memberships', only: [:index, :new]
    end
    
    resources :team_memberships, only: [:create, :edit, :update, :destroy] do
      collection do
        get :with_state
      end
      
      member do
        put :accept
        put :deny
        put :change_roles
      end
    end
    
    resources :iterations, only: [:create, :show, :edit, :update, :destroy]
    
    get 'workflow' => 'workflow#index', as: :workflow
    
    namespace 'workflow' do
      resources :team_leader, only: :index
    end
  end
  
  resources :organizations do
    namespace :scholarship do
      resources :programs, only: [:index, :new]
    end
  end
end
