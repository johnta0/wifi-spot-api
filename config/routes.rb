Rails.application.routes.draw do

  # apiの方
  namespace :api, format: 'json' do
      namespace :v1 do
          resources :spots
      end
  end
  
  # HTMLの方
  resources :spots
  root to: 'spots#index'

end
