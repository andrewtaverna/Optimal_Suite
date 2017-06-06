class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subdomain, :text
  end
end
