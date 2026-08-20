module Api
  module V1
    class ContentsController < ApplicationController
      # NOTE: Allow contents only for the authenticated user
      include Authenticatable

      before_action :set_content, only: [ :show, :update, :destroy ]
      before_action :authorize_owner!, only: [ :update, :destroy ]

      def index
        render json: Content.all, each_serializer: ContentSerializer
      end

      def show
        render json: @content, serializer: ContentSerializer
      end

      def create
        content = current_user.contents.build(content_params)
        if content.save
          render json: content, serializer: ContentSerializer, status: :created
        else
          render json: { errors: content.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @content.update(content_params)
          render json: @content, serializer: ContentSerializer
        else
          render json: { errors: @content.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @content.destroy
        render json: { message: "Deleted" }, status: :ok
      end

      private

      def set_content
        @content = Content.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Content not found" }, status: :not_found
      end

      def authorize_owner!
        unless @content.user_id == current_user.id
          render json: { error: "You are not authorized to modify this content" }, status: :forbidden
        end
      end

      def content_params
        params.require(:content).permit(:title, :body)
      end
    end
  end
end
