class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :dashboardid
      t.string :text

      t.timestamps null: false
    end
  end
end
