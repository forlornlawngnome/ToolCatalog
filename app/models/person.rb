class Person < ActiveRecord::Base
  before_save :lowercaseID
  
  
  has_and_belongs_to_many :forms
  has_many :hours
  has_many :hour_exceptions
  has_many :tool_reservations
  has_many :space_reservations
  has_many :courses, :through=>:courses_people
  has_many :categories, :through=>:courses
  has_many :tools, :through => :categories
  has_many :courses_people, -> { where(:approved=> true) }
  has_many :timelogs
  has_many :tool_logs
  has_many :checked_out_tools, :through=>:tool_logs, :source => :tool
 
  validates :name, :email, :graduation_year, :barcode, :presence => true
  validates :email, :uniqueness => true
  validates :barcode, :uniqueness => true
  
  def lowercaseID
    self.barcode = self.barcode.downcase
  end
  def signed_in
    if self.timelogs.in_today.nil? || self.timelogs.in_today.empty?
      return false
    else
      return self.timelogs.in_today.first
    end
  end
  def self.active
    if Rails.env.production?
      where("people.archived IS NOT true")
    else
      where("people.archived IS NOT ?","t")
    end
  end
  def future_tool_reservations
    self.tool_reservations.future.order(:reservation_beginning).limit(5)
  end
  def future_space_reservations
    self.space_reservations.future.order(:reservation_beginning).limit(5)
  end
  def available_courses
    return Course.where("id NOT in (?)",self.courses.pluck(:id)).order(:name)
  end
  def missing_forms
    Form.where("id not in (?)", self.forms.pluck(:id))
  end
end
