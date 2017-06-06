class AddDashboardidToResults < ActiveRecord::Migration
  def change
    add_column :results, :dashboardid, :integer
  end
end
