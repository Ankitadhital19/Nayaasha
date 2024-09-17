module Types
  module InputObject
    class OrphanageInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :location, String, required: true
    end
  end
end
