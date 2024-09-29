class Orphanage < ApplicationRecord
  include Orphanages::OrphanageRoles
  has_many :orphans, dependent: :destroy
  belongs_to :user
end
