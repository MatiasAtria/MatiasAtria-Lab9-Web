Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  devise_scope :user do
    get "users/edit" => "devise/registrations#edit", as: :edit_user_registration
    put "users" => "devise/registrations#update", as: :user_registration
    delete "users" => "devise/registrations#destroy"
  end

  root "pages#home"

  resources :owners
  resources :pets
  resources :vets

  resources :appointments do
    resources :treatments, except: [:index, :show]
  end
end