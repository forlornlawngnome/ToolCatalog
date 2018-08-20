class SpaceReservation < ActiveRecord::Base
  belongs_to :person
  belongs_to :space
  
  validates :person_id, :space_id, :reservation_beginning, :reservation_ending, :number_of_people, :presence => true
  validate :verify_num_people
  validate :end_after_beginning
  validate :verify_duration
  validate :check_other_reservations
  validate :in_future
  
  
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
    def in_future
      if self.reservation_beginning < DateTime.now.beginning_of_day
        errors.add(:reservation_beginning, "The reservation can't be in the past.")
      end
    end
    def verify_duration
      space = Space.find_by_id(self.space_id)
      reservation_time = space.max_reservable_time * 60 * 60 #Convert from hours to seconds
      duration = self.reservation_ending - self.reservation_beginning
      if reservation_time < duration.round
          errors.add(:reservation_ending, "This space can only be reserved for #{space.max_reservable_time} hours.")
      end
    end
    def end_after_beginning
      if (self.reservation_ending - self.reservation_beginning) <= 0
        errors.add(:reservation_ending, "The reservation must end at least 1 minute after it begins.")
      end
    end
    def verify_num_people
      space = Space.find_by_id(self.space_id)
      if self.number_of_people > space.max_people
        errors.add(:number_of_people, "This space can only be reserved for #{space.max_people} people at any given time.")
      end
    end
    def check_other_reservations
      space = Space.find_by_id(self.space_id)
      if space.is_reserved?(self.reservation_beginning, self.number_of_people)
        errors.add(:number_of_people, "This space already fully or partially reserved during this time. It can have #{space.max_people-space.person_reservation_count(self.reservation_beginning)} more people during this time. See the space's information for upcoming reservations.")
      end
    end
end
