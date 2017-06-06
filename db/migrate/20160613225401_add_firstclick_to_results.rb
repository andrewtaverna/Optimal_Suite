class AddFirstclickToResults < ActiveRecord::Migration
  def change
    add_column :results, :firstclick, :string
  end
end
