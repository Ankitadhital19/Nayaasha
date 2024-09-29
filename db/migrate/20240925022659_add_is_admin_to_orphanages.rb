class AddIsAdminToOrphanages < ActiveRecord::Migration[7.2]
  def change
    add_column :orphanages, :is_admin, :boolean
  end
end
