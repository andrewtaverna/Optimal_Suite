class AddTimespentToResults < ActiveRecord::Migration
  def change
    add_column :results, :timespent, :decimal
  end
end
