class Course < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :tools, :through => :category
  has_many :documentation_links
  has_and_belongs_to_many :people
  has_many :courses_people, dependent: :destroy
  
  accepts_nested_attributes_for :documentation_links, :allow_destroy => true, :reject_if => :all_blank
  
  validates :name, :presence=>true
end
