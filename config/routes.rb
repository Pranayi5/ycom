Rails.application.routes.draw do
  devise_for :users
  resources :links do
    resources :comments
    member do
      put "like", to: "links#upvote"
      put "unlike", to: "links#downvote"
      put "hide", to: "links#hide"
    end
  end

  put "hide_article", to: "article_management#hide_article"

  resources :comments do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "navigations#index"
end
