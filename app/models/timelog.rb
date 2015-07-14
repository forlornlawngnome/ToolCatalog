class Timelog < ActiveRecord::Base
  before_save :setTimeLogged
  
  belongs_to :person
  
  validates :person_id, :time_beginning, :presence => true
  
  scope :in_today, -> {where("time_beginning >= ? AND time_ending IS NULL", ApplicationHelper.today.utc)}
  scope :today, -> {where("time_beginning >= ? ",ApplicationHelper.today.utc).order("updated_at DESC")}
  
  private
    def setTimeLogged
      if self.time_ending.nil?
        self.duration = 60
      else
        self.duration = self.time_ending - self.time_beginning
      end
    end
end
