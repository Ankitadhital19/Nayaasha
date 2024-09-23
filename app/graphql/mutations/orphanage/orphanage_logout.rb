module Mutations
  module Orphanage
    class OrphanageLogout < BaseMutation
      field :message, String, null: false
      field :errors, [ String ], null: true

      def resolve
          orphanage_session_service = ::Orphanages::OrphanageAuthService.new.execute_orphanage_sign_out(context[:current_user])

          if orphanage_session_service.success?
            {
              message: "orphanage logout Successfully",
              errors: []
            }
          else
            {
              message: "failed to logout",
              errors: [ orphanage_session_service.errors ]
            }
          end
      rescue StandardError, GraphQL::ExecutionError => err
        {
          message: "failed to logout",
          errors: [ err.message ]
        }
      end
    end
  end
end
