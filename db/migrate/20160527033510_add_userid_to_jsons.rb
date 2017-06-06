class AddUseridToJsons < ActiveRecord::Migration
  def change
    add_column :jsons, :user_id, :integer
  end
end
