class Space < ActiveRecord::Base
  has_many :space_reservations
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
  
  scope :reservable, ->{where(:reservable=>true)}
  
  def is_reserved?(date, num_people)
    reservations = reservations_at(date)
    if reservations.empty?
      return false
    else
      person_count = person_reservation_count(date)
      if (person_count + num_people) >= self.max_people
        return true
      end
      return false
    end
  end
  def person_reservation_count(date)
    person_count = 0
    reservations_at(date).each do |reservation|
      person_count = person_count + reservation.number_of_people
    end
    return person_count
  end
  def reservations_at(date)
    self.space_reservations.get_reservation_at(date)
  end
end
