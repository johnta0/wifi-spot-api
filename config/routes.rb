Rails.application.routes.draw do

  # apiの方
  namespace :api, format: 'json' do
      namespace :v1 do
          # 順番逆だとルーティング失敗する(searchが#showの:idだと理解されてしまう)
          get 'spots/search' => 'spots#search'
          resources :spots, only: [:index, :show]
      end
  end

  # HTMLの方
  resources :spots
  root to: 'spots#index'

end
