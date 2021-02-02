Rails.application.routes.draw do
  get 'post/create'
  get 'post/store'
  get 'post/list'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'homes/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"
 #  Rails.application.routes.draw do
  get 'post/create'
  post 'post/store'
  get 'post/list'
  get 'post/delete/:id(.:format)', :to => 'post#destroy'
  get 'post/edit/:id(.:format)', :to => 'post#edit'
  post 'post/update/:id(.:format)', :to => 'post#update'
  post 'post_comment/:id(.:format)', :to => 'post#comment_create'
  post 'comment_edit/:id(.:format)', :to => 'post#comment_update'
  get 'comment_delete/:id(.:format)', :to => 'post#comment_delete'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # get 'homes/index'
	#   devise_for :user
	# end
end
