module Mutations
  module Orphan
    class EditOrphan < Mutations::BaseMutation
      argument :orphan_info, Types::InputObjects::OrphanInputType, required: true
      argument :id, ID, required: true

      field :orphan, Types::Orphan::OrphanType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(id:, orphan_info: {})
        begin
          orphan_service = ::Orphans::OrphanService.new(orphan_info.to_h.merge(id: id, current_user: context[:current_user])).execute_edit_orphan
          if orphan_service.success?
            {
              orphan: orphan_service.orphan,
              message: "Orphan Edited Successfully",
              errors: []
            }
          else
            {
              message: "Failed to edit",
              errors: [ orphan_service.errors ]
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
