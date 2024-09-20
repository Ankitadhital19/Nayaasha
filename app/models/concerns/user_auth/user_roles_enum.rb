module UserAuth
  module UserRolesEnum
    extend ActiveSupport::Concern

    ROLES = {
      superadmin: "superadmin",
      admin: "admin",
      member: "member"
    }.freeze

    included do
      enum roles: ROLES
    end
  end
end
