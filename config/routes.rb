Velocipede::Application.routes.draw do

  devise_for :users
  netzke

  root :to => 'site#index'
  get 'admin/index', to: 'panel#index', as: "admin_index"

  get 'bikes/new', to: 'bikes#new', as: "new_bike"
  get 'bikes/:id', to: 'bikes#show', as: "bike"

  ###########################
  # API Routes
  scope 'api', :module => :api do
    scope 'v1', :module => :v1 do
      post 'checkin' => "logs#checkin", :as => "api_checkin"
      post 'checkout' => "logs#checkout", :as => "api_checkout"
      post 'reset' => "users#password_reset", :as => "api_password_reset"

      post 'bikes/create' => "bikes#create", as: "api_create_bike"
    end
  end

end
