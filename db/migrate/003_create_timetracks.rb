class CreateTimetracks < ActiveRecord::Migration
  def self.up
    create_table :timetracks do |t|
      t.datetime :created_at
      t.integer :member_id
      t.date :date
      t.string :description
      t.float :hours_spent
    end
  end

  def self.down
    drop_table :timetracks
  end
end
