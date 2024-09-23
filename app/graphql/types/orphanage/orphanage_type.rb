module Types
  module Orphanage
    class OrphanageType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :location, String, null: false
      field :user_id, ID, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
