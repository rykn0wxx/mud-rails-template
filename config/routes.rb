Rails.application.routes.draw do
  get 'index' => 'welcome#index', :as => 'index'
  root :to => 'welcome#index'
end
