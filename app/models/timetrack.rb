class Timetrack < ActiveRecord::Base
  belongs_to :member
  validates_presence_of :member_id, :date, :description, :hours_spent
  validates_numericality_of :hours_spent
end
