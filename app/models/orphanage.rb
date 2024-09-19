class Orphanage < ApplicationRecord
  belongs_to :user

  # acts_as_tenant :organization
end
