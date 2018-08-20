class Category < ActiveRecord::Base
  has_and_belongs_to_many :tools
  has_many :maintenance_types
  has_and_belongs_to_many :courses
  has_many :courses_people, :through => :courses
  has_many :people, :through => :courses_people
  
  validates :name, :presence=>true
end
