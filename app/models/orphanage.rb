class Orphanage < ApplicationRecord
  include Orphanages::OrphanageRoles
  has_many :orphans, dependent: :destroy
  belongs_to :user

  # def admin?
  #   is_admin 
  # end
end
