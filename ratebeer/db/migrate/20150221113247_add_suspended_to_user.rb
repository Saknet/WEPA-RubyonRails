class AddSuspendedToUser < ActiveRecord::Migration
  def change
    add_column :users, :suspended, :boolean
  end
end
