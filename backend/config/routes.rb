Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users,
    path: "api/v1/auth",
    path_names: { sign_in: "login", sign_out: "logout", registration: "register" },
    controllers: {
      sessions: "api/v1/auth/sessions",
      registrations: "api/v1/auth/registrations"
    }

  namespace :api do
    namespace :v1 do
      resource :candidate_profile, only: [:show, :update]

      post "resume/upload", to: "resumes#upload"
      get "resume/status/:id", to: "resumes#status"

      resources :candidate_skills, only: [:index, :create, :update, :destroy]
      resources :work_experiences, only: [:index, :create, :update, :destroy] do
        resources :work_projects, only: [:index, :create, :update, :destroy], shallow: true
      end
      resources :educations, only: [:index, :create, :update, :destroy]
      resources :certifications, only: [:index, :create, :update, :destroy]

      namespace :sourcing do
        post "parse-job", to: "jobs#parse"
        post "refine-job", to: "jobs#refine"
        post "search", to: "candidates#search"
        get "candidates", to: "candidates#index"
        get "candidates/:id", to: "candidates#show"
        get "jobs", to: "jobs#index"
        get "jobs/:id", to: "jobs#show"
        delete "jobs/:id", to: "jobs#destroy"

        # AI Chat
        get  "chat/sessions",     to: "chat#sessions"
        get  "chat/sessions/:id", to: "chat#show"
        post "chat/message",      to: "chat#message"
        delete "chat/sessions/:id", to: "chat#destroy"

        # CSV exports (token-based, no auth required)
        get "exports/csv", to: "exports#csv"
      end
    end
  end
end
