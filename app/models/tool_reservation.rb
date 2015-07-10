class ToolReservation < ActiveRecord::Base
  belongs_to :person
  belongs_to :tool
  has_one :tool_log
  
  validates :person_id, :tool_id, :reservation_beginning, :reservation_ending, :presence => true
  validate :end_after_beginning
  validate :verify_duration
  validate :has_permission
  validate :in_future
  validate :check_other_reservations
  
  
  scope :future, ->{where("reservation_beginning > ?",DateTime.now.beginning_of_day)}
  scope :get_reservation_at, ->(date) { where( "reservation_beginning <= ? and reservation_ending >= ?", date, date ) } 
  
  def name
    return "#{self.person.name} - #{self.reservation_beginning}"
  end
  def duration
    total_seconds = self.reservation_ending - self.reservation_beginning
    Time.at(total_seconds).utc.strftime("%H hours %M minutes")
  end

  private
    def has_permission
      if !self.person.tools.include?(self.tool)
        errors.add(:tool_id, "You don't have permission to use this tool. Please see an instructer to take the appropriate training course.")
      end
    end
    def in_future
      if self.reservation_beginning < DateTime.now.beginning_of_day
        errors.add(:reservation_beginning, "The reservation can't be in the past.")
      end
    end
    def end_after_beginning
      if (self.reservation_ending - self.reservation_beginning) <= 0
        errors.add(:reservation_ending, "The reservation must end at least 1 minute after it begins.")
      end
    end
    def verify_duration
      tool = Tool.find_by_id(self.tool_id)
      reservation_time = tool.max_reservation_time * 60 * 60 #Convert from hours to seconds
      duration = self.reservation_ending - self.reservation_beginning
      if reservation_time < duration.round
          errors.add(:reservation_ending, "This tool can only be reserved for #{tool.max_reservation_time} hours.")
      end
    end
    def check_other_reservations
      tool = Tool.find_by_id(self.tool_id)
      if tool.is_reserved?(self.reservation_beginning)
        errors.add(:reservation_beginning, "This tool is already reserved during this time. See the tool's information for upcoming reservations.")
      end
    end
end
