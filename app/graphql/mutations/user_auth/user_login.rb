module Mutations
  module UserAuth
    class UserLogin < BaseMutation
      argument :session_info, Types::InputObjects::UserSessionInputType, required: true

      field :user, Types::UserAuth::UserAuthType, null: true
      field :errors, [ String ], null: false
      field :token, String, null: true

      def resolve(session_info: {})
          user_session_service = ::UserAuth::SessionService.new(session_info.to_h).execute_user_sign_in

          if user_session_service.success?
            {
              user: user_session_service.user,
              token: user_session_service.token,
              errors: []
            }
          else
            {
              errors: [ user_session_service.errors ]
            }
          end
      rescue StandardError, GraphQL::Execution::Errors => err
        {
          errors: [ err.message ]
        }
      end
    end
  end
end
