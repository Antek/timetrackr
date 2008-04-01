class Group < ActiveRecord::Base
  has_many :members
  has_many :labels
  has_many :timetracks, :through => :members, :order => 'timetracks.date ASC, timetracks.created_at ASC' do
    def weeks
      timetracks = self.find(:all)
      return [] if timetracks.empty?
      first_week = timetracks.first.date.cweek
      last_week = timetracks.last.date.cweek
      first_week..last_week
    end
  end
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def total_hours
    timetracks.sum('hours_spent')
  end
end
