class RemoveTimestampsFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :created_at, :string
    remove_column :results, :updated_at, :string
  end
end
