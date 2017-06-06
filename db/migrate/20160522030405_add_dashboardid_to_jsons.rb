class AddDashboardidToJsons < ActiveRecord::Migration
  def change
    add_column :jsons, :dashboardid, :integer
  end
end
