class AddDashboardIdToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :dashboard_id, :integer
  end
end
