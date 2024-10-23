module Mutations
  module Adaptar
    class AdaptarLogout < BaseMutation
      field :message, String, null: false
      field :errors, [ String ], null: true

      def resolve
          adaptar_signout_service = ::Adaptars::AdaptarService.new.execute_Adaptar_sign_out(context[:current_user])

          if adaptar_signout_service.success?
            {
              message: "Adaptar logout Successfully",
              errors: []
            }
          else
            {
              message: "failed to logout",
              errors: [ adaptar_signout_service.errors ]
            }
          end
      rescue StandardError, GraphQL::ExecutionError => err
        {
          message: "failed to logout",
          errors: [ err.message ]
        }
      end
    end
  end
end
