Velocipede::Application.routes.draw do

  devise_for :users
  netzke

  root :to => 'site#index'
end
