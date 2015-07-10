Rails.application.routes.draw do
  resources :categories_courses

  resources :tool_logs

  resources :timelogs

  resources :courses_people

  resources :documentation_links

  resources :courses

  resources :space_reservations

  resources :tool_reservations

  resources :spaces

  resources :hour_exceptions

  resources :hours

  resources :maintanance_actions

  resources :maintanance_types

  resources :categories_tools

  resources :categories

  resources :tools do
    collection do
      get :search
      get :catalog
      post :import
    end
  end
  resources :tool_import, :only => [:new, :create] 
  
  resources :forms_people

  resources :forms

  resources :people

  match 'studentlogin' => 'timelogs#student', via: [:get], :as=>:lab_login
  match 'toollogin' => 'tool_logs#checkout', via: [:get], :as=>:tool_login
  
  match 'admin_console' => 'admin#admin_console', via: [:get], :as=>:admin
  match 'admin/current_students' => 'admin#students', via:[:get]
  match 'admin/tools_out' => 'admin#tools_out', via:[:get]
  match 'admin/forms' => 'admin#forms', via:[:get]
  match 'admin/course_approval' => 'admin#course_approval', via:[:get]
  get 'admin/tool_import'=> redirect('/tool_import/new')
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index', :as=> :home

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
