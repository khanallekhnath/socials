module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [ :login ]

      # TODO: remove this; index for user is not required. Keeping it for development phase only.
      def index
        render json: User.all, each_serializer: UserSerializer
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, serializer: UserSerializer, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        render json: @user, serializer: UserSerializer
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def user_params
        params.require(:user)
              .permit(:email, :country, :firstName, :lastName, :password)
              .transform_keys { |key| key.to_s.underscore }
      end
    end
  end
end
