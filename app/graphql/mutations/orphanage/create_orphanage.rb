module Mutations
  module Orphanage
    class CreateOrphanage < Mutations::BaseMutation
      argument :orphanage_info, Types::InputObject::OrphanageInputType, required: true

      field :orphanage, Types::Orphanage::OrphanageType, null: false
      field :errors, [ String ], null: false

      def resolve(orphanage_info: {})
        orphanage_service = ::Orphanages::OrphanageService.new(orphanage_info.to_h).execute_create_orphanage

        if orphanage_service.success?
          {
            orphanage: orphanage_service.orphanage,
            errors: []
          }
        else
          {
            orphanage: nil,
            errors: orphanage_service.errors
          }
        end
      end
    end
  end
end
