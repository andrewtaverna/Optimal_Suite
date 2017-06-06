class AddCorrectnodeToResults < ActiveRecord::Migration
  def change
    add_column :results, :correct_node, :string
  end
end
