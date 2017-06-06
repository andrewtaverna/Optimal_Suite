class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :amount
      t.string :card_last4
      t.string :card_type
      t.integer :card_exp_month
      t.integer :card_exp_year

      t.timestamps null: false
    end
  end
end
