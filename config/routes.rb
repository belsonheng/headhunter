Rails.application.routes.draw do
  resources :documents
  
  # Devise authentication navigation
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup', password: 'users/password', edit: 'profile/personal_info'}

  authenticated :user, lambda {|u| u.type == 'JobSeeker'} do 
    root to: 'jobseeker#home', as: :authenticated_jobseeker_root
    get 'home' => 'jobseeker#home', as: :jobseeker_home
    get 'profile' => 'jobseeker#profile', as: :jobseeker_profile
  end
  authenticated :user, lambda {|u| u.type == 'Employer'} do 
    root to: 'employer#home', as: :authenticated_employer_root
    get 'home' => 'employer#home', as: :employer_home
  end

  root 'pages#index'

  #User Profile Page:
  get 'users/:id' => 'users#show'
  # Static pages
  get 'how-it-works' => 'pages#how_it_works'
  get 'employers' => 'pages#employers'

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
  
  get   'settings'        =>  'pages#settings'
  get   'integrations'    =>  'pages#integrations'

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
