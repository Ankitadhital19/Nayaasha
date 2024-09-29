module Orphanages
  module OrphanageRoles
    extend ActiveSupport::Concern

    ROLES = {
      admin: "admin",
      member: "member",
      staff: "staff"
    }.freeze

    included do
      enum roles: ROLES
    end
  end
end
