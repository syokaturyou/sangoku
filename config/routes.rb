Rails.application.routes.draw do

  resources :zatudans, only: [:index, :create]
  resources :articles, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  devise_for :members,controllers: {
  sessions: 'members/sessions',
  passwords: 'members/passwords',
  registrations: 'members/registrations'
}

  devise_for :admins, skip: [:registrations], controllers: {
  sessions: 'admins/sessions',
  passwords: 'admins/passwords'
}

  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
  end

  root to: 'homes#top'
  resources :contracts, only: [:new, :create]
  resources :sights, only: [:new, :create, :index, :destroy, :edit, :update, :show] do
    resources :evaluates, only: [:new, :create]
    resource :likes, only: [:create, :destroy]
  end
  resources :evaluates, only: [:index]
  get 'done', to: 'contracts#done', as: 'done'
  get '/search', to: 'searchs#search'
  get 'search/result' => 'searchs#result'
  get "book/search", to: "books#search"
  # get "/search", to: "books#search"

  namespace :manager do
    resources :members, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :answers, only: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :public do
    get 'chat/:id' => 'chats#show', as: 'chat'
    resources :chats, only: [:create]
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/unsubscribe' => 'members#withdrawal', as: 'withdrawal'
    resources :members, only: [:index, :show, :update, :edit]
    resources :posts, only: [:index, :show, :destroy, :create, :update, :edit, :new] do
      resources :answers, only: [:create, :new]
    end
    #answerの内、createとnewはpostに紐づける必要あり
    resources :answers, only: [:destroy, :update, :edit] do
     resources :rates, only: [:new, :create]
    end
  end

end
