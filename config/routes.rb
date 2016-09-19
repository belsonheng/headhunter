Rails.application.routes.draw do
  resources :documents

  # Devise authentication navigation
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'users/password' }, skip: :registrations #, edit: 'settings'}

  authenticated :user, lambda {|u| u.type == 'jobseeker' } do 
    root to: 'jobseeker#home', as: :jobseeker_root
    get 'home' => 'jobseeker#home', as: :jobseeker_home
    get 'profile' => 'jobseeker#profile', as: :jobseeker_profile
    get '/profile/personal_info' => 'jobseeker#personal_info', as: :jobseeker_personal_info
    get '/profile/desired_headline' => 'jobseeker#pitch', as: :jobseeker_pitch
    get '/profile/summary' => 'jobseeker#summary', as: :jobseeker_summary
    get '/profile/role_skill' => 'jobseeker#role_skill', as: :jobseeker_role_skill
    get '/profile/job_info' => 'jobseeker#job_info', as: :jobseeker_job_info
    get '/profile/history' => 'jobseeker#history', as: :jobseeker_history
    get '/profile/online_presence' => 'jobseeker#online_presence', as: :jobseeker_online_presence
    get '/profile/recommendation' => 'jobseeker#recommendation', as: :jobseeker_recommendation
    get '/profile/blocked_companies' => 'jobseeker#blocked_companies', as: :jobseeker_blocked_companies
    get 'integrations'    =>  'jobseeker#integrations', as: :jobseeker_integrations
    devise_scope :user do
      get 'settings' => 'registrations#edit', type: 'jobseeker', as: :jobseeker_account_settings
      put 'settings' => 'registrations#update', as: :jobseeker_account_update
    end
  end

  authenticated :user, lambda {|u| u.type == 'employer' } do 
    root to: 'employer#home', as: :employer_root
    get 'home' => 'employer#home', as: :employer_home
    devise_scope :user do
      get 'settings' => 'registrations#edit', type: 'employer', as: :employer_account_settings
      put 'settings' => 'registrations#update', as: :employer_account_update
    end
  end

  root 'pages#index'

  #User Profile Page:
  # get 'users/:id' => 'users#show'
  # Static pages
  get 'how-it-works' => 'pages#how_it_works'
  get 'employers' => 'pages#employers'

  devise_scope :user do
    get 'signup' => 'registrations#new_jobseeker', as: :jobseeker_signup
    post 'signup' => 'registrations#create', as: :jobseeker_registration
    get 'employer_signup' => 'registrations#new_employer', as: :employer_signup
    post 'employer_signup' => 'registrations#create', as: :employer_registration
  end

  # get 'information' => 'pages#information'

  # Onboarding pages
  scope '/onboarding' do
    get 'job-info' => 'pages#job_info'
    post 'job-info' => 'preferences#checkRecord'

    get 'online-presence'  =>  'pages#online_presence'
    post 'online-presence' => 'documents#checkRecord'
    
    get 'history' => 'pages#history'
    post 'history' => 'experience#checkRecord'

    get 'summary' => 'pages#summary'
    post 'summary'=> 'summary#checkRecord'

    get 'portfolio' => 'pages#portfolio'
    post 'portfolio' => 'portfolio#checkRecord'

    get 'role_skill' => 'pages#role_skill'
    post 'role_skill' => 'skill#checkRecord'

    get 'info' => 'pages#info'
    post 'info' => 'info#checkRecord'
  end

  # #Pages for Employers
  # get 'employer/home' => 'employer#home'
  # post 'employer/home' => 'offer#checkRecord'

  # #Pages for JobSeekers
  # get  'jobseeker/home' => 'jobseeker#home'
  # post 'jobseeker/home' => 'listing#create'
  
  # get   'settings'        =>  'pages#settings'

  # Footer navigation
  post  'email/subscribe' =>  'emails#subscribe'
  get   'sitemap'         =>  'pages#sitemap', :defaults => {:format => 'xml'}
  get   'privacy'         =>  'pages#privacy'
  get   'contact'         =>  'pages#contact'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
