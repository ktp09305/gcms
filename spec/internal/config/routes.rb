Rails.application.routes.draw do
  namespace :gcms do
    constraints(format: "json") do
      resources :snippets, format: true
    end
  end
end
