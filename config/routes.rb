Velocipede::Application.routes.draw do

  devise_for :users
  netzke

  root :to => 'site#index'
  get 'admin/index', to: 'panel#index', as: "admin_index"

  get 'bikes/new', to: 'bikes#new', as: "new_bike"
  get 'bikes/:id', to: 'bikes#show', as: "bike"

  get  'task_lists/:id/edit' => "task_lists#edit", as: "edit_task_list"

  ###########################
  # API Routes
  scope 'api', :module => :api, defaults: {format: :json} do
    scope 'v1', :module => :v1 do
      post 'checkin'  => "logs#checkin",  :as => "api_checkin"
      post 'checkout' => "logs#checkout", :as => "api_checkout"

      post 'reset'    => "users#password_reset", :as => "api_password_reset"

      get  'bikes/:id'    => "bikes#show",   as: "api_bike"
      post 'bikes/create' => "bikes#create", as: "api_create_bike"

      get  'task_lists/:id' => "task_lists#show", as: "api_task_list"
    end
  end

end
