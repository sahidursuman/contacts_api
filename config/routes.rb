Rails.application.routes.draw do
  # root 'static_pages#home'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get '/', to: redirect('/api-docs')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do 
      resources :contacts
    end
  end
end
