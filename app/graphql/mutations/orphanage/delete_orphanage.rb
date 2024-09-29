module Mutations
    module Orphanage
      class DeleteOrphanage < Mutations::BaseMutation
        argument :id, ID, required: true
        field :orphanage, Types::Orphanage::OrphanageType, null: false
        field :errors, [ String ], null: false
        field :message, String, null: false

        def resolve(id:)
          begin
            orphanage_service = ::Orphanages::OrphanageService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_orphanage

            if orphanage_service.success?
              {
                orphanage: orphanage_service.orphanage,
                message: "Orphanage deleted successfully",
                errors: []
              }
            else
              {
                message: "failed to delete",
                errors: [ orphanage_service.errors ]
              }
            end
          end
        rescue GraphQL::ExecutionError =>e
          {
            message: "failed to delete",
            errors: [ e.message ]
          }
        end
      end
    end
end
