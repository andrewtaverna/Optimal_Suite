Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/webhook' # provide a custom path

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: "registrations" }

  resource :subscription
  resource :card
  
  resources :participants
  resources :results

  get '/.well-known/acme-challenge/:id' => 'visitors#letsencrypt'

  get '/participants/new', to: 'participants#create'
  resources :jsons, except: [:new, :edit, :index]
  get 'jsons', to: 'jsons#index'
  get '/jsons/u/:dashboardid', to: 'jsons#index'
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  root to: 'visitors#index'
  get 'products/:id', to: 'products#show', :as => :products

  resources :users
  resources :dashboards
  get 'surveyresults/:id', to: 'dashboards#surveyresults'
  get 'survey/:id', to: 'surveys#survey'
  get '/finished', to: 'visitors#finished'

  get 'dashboards/:id/tree', to: 'dashboards#tree'
  get 'dashboards/:id/tasks', to: 'dashboards#tasks'
  get 'dashboards/:id/surveyinfo', to: 'dashboards#surveyinfo'
  get 'surveyresults/:id/overview', to: 'dashboards#overview'
  get 'surveyresults/:id/taskanalysis', to: 'dashboards#taskanalysis'
  get 'surveyresults/:id/participants', to: 'dashboards#participants'
end
