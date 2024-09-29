module Types
  module InputObjects
    class OrphanageInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :location, String, required: true
      argument :roles, Types::Enums::OrphanageRolesEnum, required: true
    end
  end
end
