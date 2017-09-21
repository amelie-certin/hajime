Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'enter_arena/index'
  root 'enter_arena#index'

  resources :character, only: %i(new create show)
  resources :armory, only: %i(index) do
    collection do
      get 'unequip'
      post 'equip'
    end
  end
  resources :fight, only: %i(create)
end
