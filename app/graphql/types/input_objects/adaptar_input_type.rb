module Types
  module InputObjects
    class AdaptarInputType < Types::BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end
