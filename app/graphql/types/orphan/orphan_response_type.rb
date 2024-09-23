module Types
  module Orphan
    class OrphanResponseType < Types::BaseObject
      field :orphan, [ Types::Orphan::OrphanType ], null: true
      field :errors, [ String ], null: false
    end
  end
end
