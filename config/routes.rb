Velocipede::Application.routes.draw do

  devise_for :users
  resources :users
  # The priority is based upon order of creation:
  # first created -> highest priority.

  match 'site/index' => 'site#index'

  resources :bike_brands, :except => [:edit, :delete]
  resources :bike_models, :except => [:edit, :delete]
  resources :bike_statuses
  resources :bike_styles
  resources :bike_conditions
  resources :bikes
  
  namespace :acts_as_loggable do
    resources :logs
    resources :bike_actions
    resources :user_actions
    resources :transaction_actions
  end


  #user logs
  get 'users/:loggable_id/logs' => 'user_logs#index', :as => 'user_logs'
  get 'users/:loggable_id/logs/new' => 'user_logs#new', :as => 'new_user_log'
  post 'users/:loggable_id/logs' => 'user_logs#create'
  get 'users/:loggable_id/logs/:id/edit' => 'user_logs#edit', :as => 'edit_bike_log'

  #bike logs
  get 'bikes/:loggable_id/logs' => 'bike_logs#index', :as => 'bike_logs'
  get 'bikes/:loggable_id/logs/new' => 'bike_logs#new', :as => 'new_bike_log'
  post 'bikes/:loggable_id/logs' => 'bike_logs#create'
  get 'bikes/:loggable_id/logs/:id/edit' => 'bike_logs#edit', :as => 'edit_bike_log'

  #match ':loggable_type/:loggable_id/logs' => 'acts_as_loggable/logs#index', :as => 'loggable_logs'

  root :to => 'site#index'
end
