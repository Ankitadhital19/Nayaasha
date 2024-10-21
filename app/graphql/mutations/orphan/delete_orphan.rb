module Mutations
  module Orphan
    class DeleteOrphan < Mutations::BaseMutation
      argument :id, ID, required: true
      field :orphan, Types::Orphan::OrphanType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(id:)
        begin
          orphan_service = ::Orphans::OrphanService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_orphan

          if orphan_service.success?
            {
              orphan: orphan_service.orphan,
              message: "Orphan deleted successfully",
              errors: []
            }
          else
            {
              message: "failed to delete",
              errors: [ orphan_service.errors ]
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
