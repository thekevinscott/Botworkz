ActionController::Routing::Routes.draw do |map|
  map.resources :notes

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'

  map.archived 'archived', :controller => 'projects', :action => 'archived'
  map.connect "projects/archived", :controller => "projects", :action => "archived"
  
  map.resources :sessions

  map.resources :users

  map.resources :projects

  map.resources :clients

  map.root :controller => "projects"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
