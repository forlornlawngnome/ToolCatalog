class ToolLog < ActiveRecord::Base
  before_save :setTimeLogged
  before_save :set_reservation
  
  belongs_to :tool
  belongs_to :person
  belongs_to :tool_reservation
  
  validates :tool_id, :person_id, :presence => true
  validate :has_permission
  validate :is_not_reserved
  
  
  scope :checked_out, -> {where("time_out IS NULL")}
  scope :in_today, -> {where("time_in >= ? AND time_out IS NULL", ApplicationHelper.today.utc)}
  scope :today, -> {where("time_in >= ? ",ApplicationHelper.today.utc).order("updated_at DESC")}
  
  private
  def set_reservation
    if self.tool_reservation.nil?
      res = self.tool.reservation_near(self.time_in, 15) # Can check out a bit early for the reservation
      if res.nil? || res.empty?
        return self
      elsif res.first.person.id == self.person.id
        self.tool_reservation = res.first
        return self
      end
    end
    return self
  end
  def is_not_reserved
    if self.time_out.nil?
      res = self.tool.reservation_near(self.time_in, 5)
      if !res.nil? 
        if res.first.person.id != self.person.id
          errors.add(:tool_id, "This tool has been reserved by someone else for this time period.")
        end
      end  
    end
  end
  def has_permission
    if !self.person.tools.include?(self.tool)
      errors.add(:tool_id, "You don't have permission to check out this tool. Please see an instructer to take the appropriate training course.")
    end
  end
  def setTimeLogged
    if self.time_out.nil?
      self.duration = 60
    else
      self.duration = self.time_out - self.time_in
    end
  end
end
