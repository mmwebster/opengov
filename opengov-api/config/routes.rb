Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :web_data
    end
  end
  namespace :api do
    namespace :v1 do
      resources :web_statuses
    end
  end
  # root to: "home#index" # not sure if necessary

  # namespace :api do
  #   namespace :v1, :defaults => { :format => :json } do
  #     jsonapi_resources :web_status
  #     jsonapi_resources :web_data
  #   end
  # end
end
