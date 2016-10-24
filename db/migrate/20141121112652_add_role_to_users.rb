class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :gcms_users, :role, :string
  end
end
