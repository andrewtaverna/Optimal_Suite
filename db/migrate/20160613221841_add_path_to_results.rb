class AddPathToResults < ActiveRecord::Migration
  def change
    add_column :results, :path, :string
  end
end
