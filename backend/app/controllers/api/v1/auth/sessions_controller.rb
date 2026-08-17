module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          render json: {
            success: true,
            message: "Logged in successfully.",
            data: {
              user: user_data(resource),
              token: request.env["warden-jwt_auth.token"]
            }
          }
        end

        def respond_to_on_destroy
          if current_user
            render json: { success: true, message: "Logged out successfully." }
          else
            render json: { success: false, message: "No active session." }, status: :unauthorized
          end
        end

        def user_data(user)
          {
            id: user.id,
            email: user.email,
            full_name: user.full_name,
            role: user.role
          }
        end
      end
    end
  end
end
