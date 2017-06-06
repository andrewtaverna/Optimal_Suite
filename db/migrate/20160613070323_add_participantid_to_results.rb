class AddParticipantidToResults < ActiveRecord::Migration
  def change
    add_column :results, :participantid, :integer
  end
end
