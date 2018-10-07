Rails.application.routes.draw do
  devise_for :users

  put "hide_article", to: "article_management#hide_article"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "navigations#index"
end
