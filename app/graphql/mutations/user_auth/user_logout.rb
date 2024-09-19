module Mutations
  module UserAuth
    class UserLogout < BaseMutation
      field :message, String, null: false
      field :errors, [ String ], null: true

      def resolve
        begin
          user_session_service = ::UserAuth::SessionSevice.new.execute_user_sign_out(context[:current_user])

          if user_session_service.success?
            {
              message: "User logout Successfully",
              errors: []
            }
          else
            {
              message: "failed to logout",
              errors: [ user_session_service.errors ]
            }
          end
        end
      rescue StandardError, GraphQL::ExecutionError => err
        {
          message:"failed to logout",
          errors: [err.message]
        }
      end
    end
  end
end
