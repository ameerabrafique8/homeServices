Rails.application.routes.draw do
   devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  resources :services do
    resources :bookings
    resources :reviews
  end

  # resources :users, only: [] do
  #   member do
  #     get 'dashboard'
  #   end
  # end
  #  resources :dashboards, only: [:show]
  # authenticate :user do
    get 'dashboard', to: 'dashboards#dashboard', as: :user_dashboard
  # end
  root "dashboards#dashboard"
end
