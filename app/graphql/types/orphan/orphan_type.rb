module Types
  module Orphan
    class OrphanType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :gender, String, null: false
      field :age, Integer, null: false
      field :orphanage_id, ID, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
