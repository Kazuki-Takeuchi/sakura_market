class AddAdminTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin_type, :integer
  end
end
