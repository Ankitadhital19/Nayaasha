module Resolvers
  module Orphanages
    class GetOrphanage < Resolvers::BaseResolver
      type Types::Orphanage::OrphanageResponseType, null: true

      

      def resolve
        begin
          orphanage_service = ::Orphanages::OrphanageService.new.excecute_get_orphanage

          if orphanage_service.success?
            {
              orphanage: orphanage_service.orphanage,
              errors: []
            }
          else
            {
              orphanage: nil,
              errors: [ orphanage_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          orphanage: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
