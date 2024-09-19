module Types
  module Enums
    class UserRolesEnum < BaseEnum
      ::UserAuth::UserRolesEnum::ROLES.each do |name, value|
        value(name, value)
      end
    end
  end
end
