class AddForiegnKeysToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :manager_id, :integer
    add_column :users, :supervisor_id, :integer
    add_column :users, :data_entry_operator_id, :integer
    add_column :users, :index_users_on_manager_id, :string
    add_column :users, :index_users_on_supervisor_id, :string
    add_column :users, :index_users_on_data_entry_operator_id, :string
  end
end
