Rails.application.routes.draw do

    get 'keijis/kanri', to:'keijis#kanri', as:'kanri_keiji'
    resources :categories
    resources :keijis
    resources :users, :only => [ :new, :show ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
