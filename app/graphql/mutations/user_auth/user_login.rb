module Mutations
  module UserAuth
    class UserLogin < BaseMutation
      argument :session_info, Types::InputObjects::UserSessionInputType, required: true

      field :errors, [ String ], null: false
      field :token, String, null: true
      field :message, String, null: true

      def resolve(login_info: {})
        begin
          user_session_service = ::UserAuth::SessionSevice.new(session_info.to_h).execute_user_sign_in

          if user_session_service.success?
            {
              message: user_session_service.user,
              token: user_session_service.token,
              errors: []
            }
          else
            {
              errors: [ user_session_service.errors ]
            }
          end
        end
      rescue StandardError, GraphQL::Execution::Errors => err
        {
          errors: [ err.message ]
        }
      end
    end
  end
end
