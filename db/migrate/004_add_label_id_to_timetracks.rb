class AddLabelIdToTimetracks < ActiveRecord::Migration
  def self.up
    add_column :timetracks, :label_id, :integer
  end

  def self.down
    remove_column :timetracks, :label_id
  end
end
