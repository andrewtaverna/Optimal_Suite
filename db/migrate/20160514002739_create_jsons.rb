class CreateJsons < ActiveRecord::Migration
  def change
    create_table :jsons do |t|
      t.string :text, null:false
      t.string :parent, null:false
      # Object's id is built in
    end
  end
end
