class Timetrack < ActiveRecord::Base
  belongs_to :member
  belongs_to :label
  validates_presence_of :member_id, :date, :description, :hours_spent
  validates_numericality_of :hours_spent
  
  def label_name=(name)
    @label_name = name.downcase
  end
  
  def after_save
    if self.label.nil?
      self.label = Label.find_or_create_by_name_and_group_id(@label_name, member.group_id)
      save
    end
  end
end
