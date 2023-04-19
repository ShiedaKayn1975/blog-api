class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def create
    if params[:username].blank? || params[:password].blank?
      render_error 'Username and password are required', :bad_request
      return
    end

    user = User.find_by_email(params[:username].to_s.downcase)

    if user&.authenticate(params[:password]) && (token = user.generate_token)
      render json: { token: token }, status: :ok
    else
      render_error 'Wrong email or password', :unauthorized
    end
  end

  def profile
    profile = @current_user.as_json(except: [:password_digest])
    render json: profile, status: :ok
  end
end