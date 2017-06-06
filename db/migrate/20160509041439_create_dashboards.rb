class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.text :title
      t.text :description
      t.timestamps null: false
      
    end
  end
end
