module Api
  module V2
    class ContentsController < Api::V1::ContentsController
      # NOTE: we are extenxing V1 ContentsController and changing show method's behavior only.
      #
      def show
        render json: @content, serializer: Api::V2::ContentSerializer
      end
    end
  end
end
