
module Authenticatable
  extend ActiveSupport::Concern

  included do
    # NOTE: this enforces login to read the contents
    # To allow the read access to the world, use this
    # before_action :authenticate_request, except: [:index, :show]
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = token && JsonWebToken.decode(token)

    if decoded && (user = User.find_by(id: decoded[:user_id]))
      @current_user = user
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
