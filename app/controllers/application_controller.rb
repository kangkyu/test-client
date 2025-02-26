class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    @current_user = nil
    if header_token
      @current_user = User.find_by(auth_token: header_token)
    end

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  private

  def header_token
    if auth = request.headers["Authorization"].presence
      auth.split(" ").last
    end
  end
end
