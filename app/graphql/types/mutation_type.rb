# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, description: "Mutation for creating user", mutation: Mutations::UserAuth::CreateUser
    field :user_login, description: "Mutation for user login", mutation: Mutations::UserAuth::UserLogin
    field :user_logout, description: "Mutation for user logout", mutation: Mutations::UserAuth::UserLogout
    field :create_orphanage, description: "Mutation for creating orphanage", mutation: Mutations::Orphanage::CreateOrphanage
    field :delete_orphanage, description: "Mutation for deleting orphanage", mutation: Mutations::Orphanage::DeleteOrphanage
    field :edit_orphanage, description: "Mutation for editing orphanage", mutation: Mutations::Orphanage::EditOrphanage
    field :orphanage_login, description: "Mutation for orphanage login", mutation: Mutations::Orphanage::OrphanageLogin
    field :orphanage_logout, description: "Mutation for orphanage logout", mutation: Mutations::Orphanage::OrphanageLogout
    field :create_orphan, description: "Mutation for creating orphan", mutation: Mutations::Orphan::CreateOrphan
    field :edit_orphan, description: "Mutation for creating orphan", mutation: Mutations::Orphan::EditOrphan
    field :delete_orphan, description: "Mutation for deleting orphan", mutation: Mutations::Orphan::DeleteOrphan
    field :register_adaptar, mutation: Mutations::Adaptar::RegisterAdaptar
    field :adaptar_login, description: "Mutation for adaptar login", mutation: Mutations::Adaptar::AdaptarLogin
    field :adaptar_logout, description: "Mutation for adaptar logout", mutation: Mutations::Adaptar::AdaptarLogout
  end
end
