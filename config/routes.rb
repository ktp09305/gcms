Gcms::Engine.routes.draw do
  devise_for :gcms_users,
    class_name: "Gcms::User",
    failure_app:  'Gcms::Devise::FailureApp',
    module: :devise,
    controllers: { registrations: "users/registrations" }
  constraints(format: "json") do
    resources :templates, format: true
    resources :snippets, except: [:new, :edit], format: true
    resources :pages, format: true do
      collection do
        post 'sorting'
      end
    end
    resources :assets, format: true, as: :gcms_assets
    resources :users, only: [:index, :destroy], format: true
    resources :resources, only: :index, format: true
    resource :settings, only: [:show, :update], format: true
    get '/users/gcms_user' => "users#gcms_user", format: true
    post "/users/from_gcms" => "users#create", format: true
  end
  post "/assets/ckeditor" => "assets#ckeditor"
  constraints(format: "html") do
    get "/(*path)" => "gcms#index"
  end

end
Rails.application.routes.draw do
    root 'gcms/public/pages#show'
    get "*path" => "gcms/public/pages#show"
end
