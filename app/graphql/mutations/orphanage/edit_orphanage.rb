module Mutations
  module Orphanage
    class EditOrphanage < Mutations::BaseMutation
      argument :orphanage_info, Types::InputObjects::OrphanageInputType, required: true
      argument :id, ID, required: true

      field :orphanage, Types::Orphanage::OrphanageType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(id:, orphanage_info: {})
        begin
          orphanage_service = ::Orphanages::OrphanageService.new(orphanage_info.to_h.merge(id: id, current_user: context[:current_user])).execute_edit_orphanage
          if orphanage_service.success?
            {
              orphanage: orphanage_service.orphanage,
              message: "Orphanage Edited Successfully",
              errors: []
            }
          else
            {
              message: "Failed to edit",
              errors: [ orphanage_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => e
        {
          orphanage: nil,
          errors: [ e.message ]
        }
      end
    end
  end
end
