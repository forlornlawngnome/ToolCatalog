class HourException < ActiveRecord::Base
  belongs_to :person
  
  validates :time_beginning, :time_ending, :person_id, :presence => true
  
  scope :future, ->{where("time_beginning > ?",DateTime.now.beginning_of_day)}
  scope :now, -> {where("time_beginning <= ? and time_ending >= ?",DateTime.now,DateTime.now)}
end
