Rails.application.routes.draw do
  root  'pages#index'
  resources :documents

  # Devise authentication navigation
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup', password: 'users/password', edit:'edit'}

  # Static pages
  get   'how-it-works'  =>  'pages#how_it_works'
  get   'employers'     =>  'pages#employers'

  # Onboarding pages
  get   'onboarding/job-info'         =>  'pages#job_info'
  get   'onboarding/online-presence'  =>  'pages#online_presence'
  get   'onboarding/history'          =>  'pages#history'

  #Pages for Employers
  get   'employer/home'   =>  'employer#home'

  #Pages for JobSeekers
  get  'jobseeker/home'   =>  'jobseeker#home'
  post 'jobseeker/home'   =>  'documents#checkRecord'

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
