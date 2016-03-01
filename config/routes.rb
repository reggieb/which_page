Rails.application.routes.draw do
  root to: 'questions#index'
  
  resources :questions, only: [:index, :create]
  resources :keywords, only: [:index]
  resources :source_pages
end
