class Timelog < ActiveRecord::Base
  before_save :setTimeLogged
  
  belongs_to :person
  
  validates :person_id, :time_in, :presence => true
  
  scope :in_today, -> {where("time_in >= ? AND time_out IS NULL", ApplicationHelper.today.utc)}
  scope :today, -> {where("time_in >= ? ",ApplicationHelper.today.utc).order("updated_at DESC")}
  
  private
    def setTimeLogged
      if self.time_out.nil?
        self.duration = 60
      else
        self.duration = self.time_out - self.time_in
      end
    end
end
