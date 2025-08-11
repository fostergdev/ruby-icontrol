Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "sessions#new"
  namespace :user do
    root to: "ci#index"
    get "ci_entries/batch_new", to: "ci_entries#batch_new", as: "ci_entries_batch_new"
    post "ci_entries/batch_create", to: "ci_entries#batch_create", as: "ci_entries_batch_create"
    resources :ci, controller: "ci", as: "ci_months" do
      resources :ci_entries, only: [ :new, :create, :destroy, :edit, :update ]
    end
  end
end
