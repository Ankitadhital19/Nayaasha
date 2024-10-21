module Types
  module Orphan
    class OrphanType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :gender, String, null: false
      field :age, Integer, null: false
    end
  end
end
