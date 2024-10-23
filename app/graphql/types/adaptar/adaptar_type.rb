module Types
  module Adaptar
    class AdaptarType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      # field :password, String, null: false
      # field :password_confirmation, String, null: false
    end
  end
end
