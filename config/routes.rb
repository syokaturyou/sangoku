Rails.application.routes.draw do

   devise_for :members,controllers: {
   sessions: 'members/sessions',
   passwords: 'members/passwords',
   registrations: 'members/registrations'
 }
   devise_for :admins, controllers: {
   sessions: 'admins/sessions',
   passwords: 'admins/passwords',
   registrations: 'admins/registrations'
}

  root to: 'homes#top'
  resources :contracts, only: [:new, :create]
  get 'done', to: 'contracts#done', as: 'done'

  get '/search', to: 'searchs#search'
  get 'search/result' => 'searchs#result'

  namespace :manager do
    resources :members, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :answers, only: [:destroy]
  end

  namespace :public do
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/unsubscribe' => 'members#withdrawal', as: 'withdrawal'
    resources :members, only: [:show, :update, :edit]
    resources :posts, only: [:index, :show, :destroy, :create, :update, :edit, :new] do
      resources :answers, only: [:create, :new]
    end
    #answerの内、createとnewはpostに紐づける必要あり
    resources :answers, only: [:destroy, :update, :edit] do
     resources :rates, only: [:new, :create]
    end
  end

end
