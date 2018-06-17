Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :budgets
      resources :categories
      resources :expenses
      resources :memos
      resources :people
      resources :users
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
