module Mutations
  module Orphanage
    class OrphanageLogin < BaseMutation
      argument :session_info, Types::InputObjects::OrphanageSessionInputType, required: true

      field :orphanage, Types::Orphanage::OrphanageType, null: true
      field :errors, [ String ], null: false
      field :token, String, null: true

      def resolve(session_info: {})
          orphanage_session_service = ::Orphanages::OrphanageAuthService.new(session_info.to_h).execute_orphanage_sign_in

          if orphanage_session_service.success?
            {
              orphanage: orphanage_session_service.orphanage,
              token: orphanage_session_service.token,
              errors: []
            }
          else
            {
              errors: [ orphanage_session_service.errors ]
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
