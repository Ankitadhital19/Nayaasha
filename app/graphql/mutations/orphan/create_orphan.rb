module Mutations
  module Orphan
    class CreateOrphan < Mutations::BaseMutation
      argument :orphan_info, Types::InputObjects::OrphanInputType, required: true

      field :orphan, Types::Orphan::OrphanType, null: false
      field :errors, [ String ], null: false

      def resolve(orphan_info: {})
        orphan_service = ::Orphan::OrphanService.new(orphan_info.to_h.merge(current_user: context[:current_user])).execute_create_orphan

        if orphan_service.success?
          {
            orphan: orphan_service.orphan,
            errors: []
          }
        else
          {
            orphan: nil,
            errors: [ orphan_service.errors ]
          }
        end
      rescue GraphQL::ExecutionError => e
        {
          orphan: nil,
          errors: [ e.message ]
        }
      end
    end
  end
end
