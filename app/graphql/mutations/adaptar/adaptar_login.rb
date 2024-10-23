module Mutations
  module Adaptar
    class AdaptarLogin < BaseMutation
      argument :adaptar_info, Types::InputObjects::AdaptarInputType, required: true

      field :adaptar, Types::Adaptar::AdaptarType, null: true
      field :errors, [ String ], null: false

      def resolve(adaptar_info: {})
          adaptar_session_service = ::Adaptars::AdaptarService.new(adaptar_info.to_h).execute_adaptar_sign_in

          if adaptar_session_service.success?
            {
              adaptar: adaptar_session_service.adaptar,
              errors: []
            }
          else
            {
              errors: [ adaptar_session_service.errors ]
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
