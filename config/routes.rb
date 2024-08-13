Rails.application.routes.draw do
  resources :students
  resources :courses do
    resources :assignments
  end
  resources :enrollments
  
  # Add a root path if you haven't already
  root 'courses#index'
end