Rails.application.routes.draw do
  post '/import_products',to: "products#import_products"  
  post '/import_from_excel',to: "products#import_from_excel"
  #get "/import_products/products"
  resources :products
  root "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
