Rails.application.routes.draw do
  namespace :methods do
  get 'eqsystem/gausselimination'
  end

  namespace :methods do
  get 'eqsystem/lu'
  end

  namespace :methods do
  get 'eqsystem/gaussseidel'
  end

  namespace :methods do
  get 'eqsystem/richardson'
  end

  namespace :methods do
  get 'eqsystem/sor'
  end

  namespace :methods do
  get 'eqsystem/jacobi'
  end

  namespace :methods do
  get 'one_variable/bisection'
  end

  namespace :methods do
  get 'one_variable/false_rule'
  end

  namespace :methods do
  get 'one_variable/fixed_point'
  end

  namespace :methods do
  get 'one_variable/secant'
  end

  namespace :methods do
  get 'one_variable/newton_raphson'
  end

  namespace :methods do
  get 'one_variable/newton2'
  end

  namespace :methods do
  get 'one_variable/fixed_point'
  end

 

  get 'methods/index'

  get 'tools/index'
  get 'welcome/index'
  get 'methods/index'
  post 'tools/add' => 'tools#add'
  post 'tools/funct' => 'tools#funct'
  post 'tools/incremental' => 'tools#incremental'
  post 'tools/interval' => 'tools#interval'
  post 'tools/criteria' => 'tools#criteria'
  
  post 'methods/one_variable/punto_fijo' => 'methods/one_variable#punto_fijo'
  post 'methods/one_variable/bisection2' => 'methods/one_variable#bisection2'
  post 'methods/one_variable/reglaFalsa' => 'methods/one_variable#reglaFalsa'
  post 'methods/one_variable/newtonModificado' => 'methods/one_variable#newtonModificado'
  get 'methods/one_variable/fixed_point' => 'fixed_point'
  post 'methods/one_variable/secante' => 'methods/one_variable#secante'
  post 'methods/one_variable/newtonRaphson' => 'methods/one_variable#newtonRaphson'
  
  post 'methods/eqsystem/jac' => 'methods/eqsystem#jac'
  post 'methods/eqsystem/ric' => 'methods/eqsystem#ric'
  post 'methods/eqsystem/gas' => 'methods/eqsystem#gas'
  post 'methods/eqsystem/sor3' => 'methods/eqsystem#sor3'
  post 'methods/eqsystem/gausselimination2' => 'methods/eqsystem#gausselimination2'
  
  
  resources :posts
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

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
