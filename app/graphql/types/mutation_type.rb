# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_orphanage, description: "Mutation for creating asset", mutation: Mutations::Orphanage::CreateOrphanage
  end
end
