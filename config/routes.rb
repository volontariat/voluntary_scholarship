Rails.application.routes.draw do
  get '/products/scholarship' => 'product/scholarship#index', as: 'scholarship_product'
end
