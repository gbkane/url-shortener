Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#readme'

  resources :short_urls, path: '', only: :show

  namespace :api, defaults: {format: :json} do
    resources :short_urls do
      member do
        patch :expire
      end
    end
  end
end
