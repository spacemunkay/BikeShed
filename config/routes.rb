Velocipede::Application.routes.draw do

  devise_for :users
  netzke

  root :to => 'site#index'
  ###########################
  # API Routes
  scope 'api', :module => :api do
    scope 'v1', :module => :v1 do
      post 'checkin' => "logs#checkin", :as => "api_checkin"
      post 'checkout' => "logs#checkout", :as => "api_checkout"
      post 'reset' => "users#password_reset", :as => "api_password_reset"
    end
  end

end
