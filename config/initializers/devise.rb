module Gcms
  module Devise

    class FailureApp < ::Devise::FailureApp

      include ::Gcms::Engine.routes.url_helpers

      def redirect_url
        new_gcms_user_session_path
      end

    end

  end
end
