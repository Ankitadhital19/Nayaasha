module Mutations
  module Orphan
    class CreateOrphan < Mutations::BaseMutation
      argument :orphan_info, Types::InputObjects::OrphanInputType, required: true
      argument :orphanage_id, ID, required: true

      field :orphan, Types::Orphan::OrphanType, null: true
      field :errors, [ String ], null: false

      def resolve(orphan_info: {}, orphanage_id:)
        orphan_service = ::Orphans::OrphanService.new(orphan_info.to_h.merge(orphanage_id: orphanage_id, current_user: context[:current_user])).execute_create_orphan

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
