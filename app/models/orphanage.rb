class Orphanage < ApplicationRecord
  has_many :orphans, dependent: :destroy
  belongs_to :user
end
