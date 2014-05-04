Velocipede::Application.routes.draw do

  devise_for :users
  netzke

  root :to => 'site#index'
  get 'admin/index', to: 'panel#index', as: "admin_index"

  get 'bikes/new', to: 'bikes#new', as: "new_bike"
  get 'bikes/:id', to: 'bikes#show', as: "bike"

  get  'task_lists/:id/edit' => "task_lists#edit", as: "edit_task_list"

  get  'time_entries'     => "time_entries#index", as: "time_entries"
  get  'time_entries/new' => "time_entries#new",   as: "new_time_entry"

  ###########################
  # API Routes
  scope 'api', :module => :api, defaults: {format: :json} do
    scope 'v1', :module => :v1 do
      post 'checkin'  => "logs#checkin",  :as => "api_checkin"
      post 'checkout' => "logs#checkout", :as => "api_checkout"

      post 'reset'    => "users#password_reset", :as => "api_password_reset"

      get  'bikes/:id'    => "bikes#show",   as: "api_bike"
      post 'bikes/create' => "bikes#create", as: "api_create_bike"

      get  'task_lists/:id' => "task_lists#show",   as: "api_task_list"

      put  'tasks/update' => "tasks#update", as: "api_update_task"

      post 'time_entries/create' => "time_entries#create", as: "api_create_time_entry"
      delete 'time_entries/:id' => "time_entries#delete", as: "api_delete_time_entry"
    end
  end

end
