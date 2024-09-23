class CreateOrphans < ActiveRecord::Migration[7.2]
  def change
    create_table :orphans do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.references :orphanage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
