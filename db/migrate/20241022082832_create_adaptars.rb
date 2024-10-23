class CreateAdaptars < ActiveRecord::Migration[7.2]
  def change
    create_table :adaptars do |t|
      t.string :email
      t.string :password_digest
      t.references :orphanage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
