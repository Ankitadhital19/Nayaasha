module Types
  module Adaptar
    class AdaptarResponseType < Types::BaseObject
      field :adaptar, [ Types::Adaptar::AdaptarType ], null: true
      field :errors, [ String ], null: false
    end
  end
end
