Rails.application.routes.draw do
  root 'courses#index'

  resources :courses do
    resources :assignments
  end
  
  resources :students
  resources :enrollments
end