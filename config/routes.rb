Rails.application.routes.draw do
  
  root 'builds#index'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { omniauth_callbacks: "callbacks" }
  resources :users, except:[:index, :new]

  resources :posts do 
    resources :comments, module: :posts
  end
  
  resources :builds, only: :index do
    collection do
      post :import
      get :autocomplete
    end
  end
  
  get 'builds/t/:b_type', to: 'builds#index', as: "b_type"
  resources :builds do
    resources :comments, module: :builds
  end
  
  resources :showcases
  resources :showcases do 
    resources :comments, module: :showcases
  end
  
  
  get 'contact_us', to: 'contacts#new'
  resources :contacts, as: 'contacts', only: [:new, :create]
  
  namespace :admin do
    get 'simple_dashboard/index'
    get 'simple_dashboard/posts'
    get 'simple_dashboard/builds'
    get 'simple_dashboard/users'
    get 'simple_dashboard/showcases'
  end
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'tags/:tag', to: 'posts#index', as: "tag"
  get 'about', to: 'pages#about'
  get 'sitemap' => 'home#sitemap'
  get 'robots' => 'home#robots', format: :text#, defaults: { format: :text }
  get '*path', to: 'application#handle_404'
end
