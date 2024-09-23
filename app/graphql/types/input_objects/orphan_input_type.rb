module Types
  module InputObjects
    class OrphanInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :gender, String, required: true
      argument :age, Integer, required: true
    end
  end
end
