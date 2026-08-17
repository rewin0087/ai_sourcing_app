module Api
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :role)
        end

        def account_update_params
          params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :full_name)
        end

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: {
              success: true,
              message: "Account created successfully.",
              data: {
                user: {
                  id: resource.id,
                  email: resource.email,
                  full_name: resource.full_name,
                  role: resource.role
                }
              }
            }, status: :created
          else
            render json: {
              success: false,
              error: "Registration failed.",
              errors: resource.errors.full_messages
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
