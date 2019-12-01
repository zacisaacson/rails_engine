Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
     namespace :v1 do
       namespace :merchants do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
         get '/:id/items', to: 'items#index'
         get '/:id/invoices', to: 'invoices#index'
       end
       namespace :customers do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
       end
       namespace :items do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
       end
       namespace :invoices do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
         get '/:id/transactions', to: 'transactions#index'
         get '/:id/invoice_items', to: 'invoice_items#index'
         get '/:id/items', to: 'items#index'
         get '/:id/customer', to: 'customers#show'
       end
       namespace :transactions do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
       end
       namespace :invoice_items do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
       end

       resources :merchants, only: [:index, :show]
       resources :customers, only: [:index, :show]
       resources :items, only: [:index, :show]
       resources :invoices, only: [:index, :show]
       resources :transactions, only: [:index, :show]
       resources :invoice_items, only: [:index, :show]
     end
   end
end
