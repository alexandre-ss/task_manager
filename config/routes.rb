Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :tasks 

  resources :profiles, only: %i[show new create update edit] do
    get 'private_page', on: :member
    post 'change_privacy', on: :member
    resources :comments, only: %i[index]
  end

  resources :pluses, only: %i[create destroy]
  resources :minuses, only: %i[create destroy]
  get '/task_report', to: 'task_report#index', as: :task_report
  put '/complete_task/:id', to: 'tasks#complete', as: :task_complete
end
