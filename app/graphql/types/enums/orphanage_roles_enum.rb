module Types
  module Enums
    class OrphanageRolesEnum < BaseEnum
      ::Orphanages::OrphanageRoles::ROLES.each do |name, value|
        value(name, value)
      end
    end
  end
end
