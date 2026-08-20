module Api
  module V2
    class ContentSerializer < ::ContentSerializer
      attributes :user

      def user
        object.user.id
      end
    end
  end
end
