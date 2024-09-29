class ChangeRoleToRolesInOrphanages < ActiveRecord::Migration[7.2]
  def change
    remove_column :orphanages, :role, :string

    add_column :orphanages, :roles, :string
  end
end
