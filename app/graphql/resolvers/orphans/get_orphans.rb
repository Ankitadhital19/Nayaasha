module Resolvers
  module Orphans
    class GetOrphans < Resolvers::BaseResolver
      type Types::Orphan::OrphanResponseType, null: true

      def resolve
        begin
          orphan_service = ::Orphans::OrphanService.new.excecute_get_orphans

          if orphan_service.success?
            {
              orphan: orphan_service.orphans,
              errors: []
            }
          else
            {
              orphan: nil,
              errors: [ orphan_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          orphan: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
