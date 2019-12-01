Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
     namespace :v1 do
       namespace :merchants do
         get '/find', to: 'query#find'
         get '/find_all', to: 'query#find_all'
         get '/random', to: 'query#random'
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
       end

       resources :merchants, only: [:index, :show]
       resources :customers, only: [:index, :show]
       resources :items, only: [:index, :show]
       resources :invoices, only: [:index, :show]
     end
   end
end
