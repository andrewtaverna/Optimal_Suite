class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|

      t.string :email, null:false
      t.integer :dashboardid, null:false

      t.timestamps null: false
    end
  end
end
