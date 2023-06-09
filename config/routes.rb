Rails.application.routes.draw do    
  root to: "admin/courses#index" # todo change it 

  devise_for :users
  
  namespace :admin do 
    resources :admins
    resources :school_admins
    resources :students
    resources :batches do
      member do
        post :requests, to: 'enrollments#create_request', as: :create_request
      end
    end

    resources :courses
    resources :enrollments
    resources :schools
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
