module Types
  module Orphanage
    class OrphanageType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :location, String, null: false
    end
  end
end
