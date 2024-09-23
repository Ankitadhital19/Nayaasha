module Types
  module InputObjects
    class OrphanageSessionInputType < BaseInputObject
      argument :orphanage_id, ID, required: true
      argument :roles, Types::Enums::UserRolesEnum, required: true
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
