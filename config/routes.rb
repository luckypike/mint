Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  root 'pages#index'

  get :robots, to: 'pages#robots'
  get :contacts, to: 'pages#contacts'
  get :instagram, to: 'pages#instagram'

  get :wishlist, to: 'wishlists#show'

  get :search, to: 'search#index'

  resources :variants, except: [:show] do
    collection do
      get :list
    end

    member do
      post :wishlist
      post :cart
    end

    resources :availabilities, only: %i[index create destroy]
  end

  resources :acts, only: :create

  resources :categories, except: [:show]

  resources :certs, only: [:index]

  resources :themes, except: [:show]

  get '/catalog/morning', to: redirect('/catalog')

  scope path: :catalog, as: :catalog do
    get '', to: 'variants#all'
    # get :last, controller: :variants
    # get :latest, controller: :variants
    # get :sale, controller: :variants
    # get :soon, controller: :variants
    # get :premium, controller: :variants
    # get :stayhome, controller: :variants
    # get 'basic', to: 'variants#stayhome'
    # get :morning, controller: :variants
    # get ':slug', to: 'products#category', as: :category, constraints: lambda { |request| Category.find_by_slug(request.params[:slug]).present? }
    get ':id', to: 'themes#show', constraints: ->(request) { Theme.find_by(slug: request.params[:id]).present? }, as: :theme
    get ':slug', to: 'categories#show', constraints: ->(request) { Category.find_by(slug: request.params[:slug]).present? }, as: :category
    # get ':slug', to: 'categories#show', as: :category
    get ':slug/:id', to: 'variants#show', as: :variant
  end

  devise_for :users,
    path: '',
    only: :sessions,
    controllers: {
      sessions: :sessions
    },
    path_names: {
      sign_in: 'login', sign_out: 'logout'
    }

  devise_scope :user do
    post 'auth/apple(/:from)', to: 'users/omniauth_callbacks#apple'
    post :recovery, controller: :sessions, as: :recovery_user_session
    get :auth, controller: :sessions, as: :auth_user_session
  end

  resource :account, only: :show do
    scope module: :accounts do
      resource :password, only: %i[show update]

      resource :user, only: %i[show update] do
        collection do
          get :password
        end
      end
    end
  end

  namespace :dashboard, module: nil do
    get '', to: 'dashboard#index'

    namespace :catalog, module: nil do
      get '', to: 'dashboard#catalog'
      post '', to: 'dashboard#catalog_update'
      get :items, to: 'dashboard#items'
      post :items, to: 'dashboard#items_update'
      # get :variants, to: 'dashboard#variants'
      # post :variants, to: 'dashboard#variants_update'
    end

    get :archived, to: 'dashboard#archived'
    get :cart, to: 'dashboard#cart'
    get :refunds, to: 'dashboard#refunds'
    get :wishlists, to: 'dashboard#wishlists'
    get :users, to: 'dashboard#users'
    get '/users/:id', to: 'dashboard#user', as: 'user'
  end

  resources :sizes
  resources :sizes_groups

  resources :collections

  scope format: false do
    namespace 'service', module: nil do
      get '', to: 'service#index'
      get 'delivery', to: 'service#delivery'
      get 'return', to: 'service#return'
      get 'refund', to: 'refunds#refund', format: :json
    end
  end

  resources :kits do
    collection do
      get :control
    end
  end

  resources :images, only: [:create, :show, :destroy] do
    collection do
      post :weight
    end
  end


  resources :colors, except: [:show]

  resources :discounts

  # resources :products, path: :catalog do
  #   member do
  #     # post :publish
  #     # post :archive
  #     get :info
  #     get 'similar/:simid', to: 'products#similar', as: 'similar'
  #   end
  #
  #   collection do
  #     # get 'control', to: 'products#control', as: :control
  #     # get 'control/archive', to: 'products#control'
  #     # get :all
  #     get :latest
  #     # get :golovina
  #     # get :kits
  #     get :sale
  #     get ':slug', to: 'products#category', as: :category, constraints: lambda { |request| Category.find_by_slug(request.params[:slug]).present? }
  #   end
  # end

  # resources :products, path: :catalog do
  #   resources :variants, only: [:create]
  #   post :wishlist, on: :member

  #   collection do
  #     get :all
  #     get :latest
  #     get :sale
  #   end
  # end

  # get 'account/orders', to: 'users#account'

  resources :posts

  resources :statistics

  resources :promos do
    collection do
      get :last
    end
  end

  resources :refunds do
    member do
      post :done
    end
  end

  resources :orders, only: [] do
    collection do
      post :paid
    end

    member do
      post :delivery
      patch :checkout
      post :archive
      post :unarchive
      get :pay
    end
  end

  resources :order_items, only: %i[destroy]

  get :cart, to: 'orders#cart'

  resources :slides, except: [:show]
end
