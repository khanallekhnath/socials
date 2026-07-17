module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def create
          user = User.find_by(email: params[:email])

          if user && user.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: user.id)

            render json: signin_response(user, token), status: :ok
          else
            render json: { error: "Invalid email or password" }, status: :unauthorized
          end
        end

        private
        # NOTE: active_model_serializer has no effect on it.
        def signin_response(user, token)
          {
            data: {
              id: user.id,
              type: "users",
              attributes: {
                token: token,
                email: user.email,
                name: "#{user.first_name} #{user.last_name}",
                country: user.country,
                createdAt: user.created_at.iso8601,
                updatedAt: user.updated_at.iso8601
              }
            }
          }
        end
      end
    end
  end
end
