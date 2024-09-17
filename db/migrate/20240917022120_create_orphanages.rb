class CreateOrphanages < ActiveRecord::Migration[7.2]
  def change
    create_table :orphanages do |t|
      t.string :name
      t.string :location
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
