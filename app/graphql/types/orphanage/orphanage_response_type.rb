module Types
  module Orphanage
    class OrphanageResponseType < Types::BaseObject
      field :orphanage, Types::OrphanageType, null: true
      field :errors, [ String ], null: false
    end
  end
end
