class AddQuestionidToResults < ActiveRecord::Migration
  def change
    add_column :results, :questionid, :integer
  end
end
