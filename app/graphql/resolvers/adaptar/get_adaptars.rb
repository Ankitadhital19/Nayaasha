module Resolvers
  module Adaptar
    class GetAdaptars < Resolvers::BaseResolver
      type Types::Adaptar::AdaptarResponseType, null: true

      def resolve
        begin
          adaptar_service = ::Adaptars::AdaptarService.new.excecute_get_adaptars

          if adaptar_service.success?
            {
              adaptar: adaptar_service.adaptar,
              errors: []
            }
          else
            {
              adaptar: nil,
              errors: [ adaptar_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          adaptar: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
