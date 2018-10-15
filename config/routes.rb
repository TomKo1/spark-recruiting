Rails.application.routes.draw do
  root to: 'short_urls#new'
  resources :short_urls, only: [:create, :show]
  get '/:short_url', to: 'short_urls#redirect_original', as: :redirect_with_short
end
