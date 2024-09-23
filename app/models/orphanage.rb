class Orphanage < ApplicationRecord
  has_many :orphans, dependent: :destroy
end
