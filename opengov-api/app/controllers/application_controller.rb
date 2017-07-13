class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising exception
  protect_from_forgery with: :null_session
end
