class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :dashboardid
      t.string :text

      t.timestamps null: false
    end
  end
end
