class RemoveOrphanageIdAndPasswordDigestFromAdaptars < ActiveRecord::Migration[7.2]
  def change
    remove_column :adaptars, :orphanage_id, :bigint if column_exists?(:adaptars, :orphanage_id)
    remove_column :adaptars, :password_digest, :string if column_exists?(:adaptars, :password_digest)
  end
end
