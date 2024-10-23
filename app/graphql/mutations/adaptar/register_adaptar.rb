module Mutations
  module Adaptar
    class RegisterAdaptar < Mutations::BaseMutation
      argument :adaptar_info, Types::InputObjects::AdaptarInputType, required: true

      field :message, String, null: true
      field :errors, [ String ], null: false

      def resolve(adaptar_info:)
        # Initialize the Adaptar service with the provided input
        adaptar_reg_service = ::Adaptars::AdaptarService.new(adaptar_info.to_h).execute_adapatar_reg

        if adaptar_reg_service.success?
          {
            message: "Adaptar registered successfully",
            errors: []
          }
        else
          {
            message: nil,
            errors: [ adaptar_reg_service.errors ]
          }
        end
      rescue StandardError => err
        {
          message: "Adaptar registration failed",
          errors: [ err.message ]
        }
      end
    end
  end
end
