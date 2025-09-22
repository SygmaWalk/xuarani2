class RemoveNombreFromRoles < ActiveRecord::Migration[8.0]
  def change
    remove_column :roles, :nombre, :string
  end
end
