class Person < ActiveRecord::Base
  has_secure_password
  before_save :lowercaseID
  before_save :remove_tool_permissions
  before_save :add_tool_permissions
  
  
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
  validates :password, :presence => true, :on => :create  
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
    if !self.courses.empty?
      return Course.where("id NOT in (?)",self.courses.pluck(:id)).order(:name)
    else
      return Course.all
    end
  end
  def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Person.exists?(column => self[column])
    end
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    PersonMailer.password_reset(self).deliver
  end

  def add_tool_permissions
    give_access = true
    
    if give_access
      course = Course.where("lower(name) like ?","%hand tool%").first
      if !course.nil?
        if !self.courses.pluck(:course_id).include?(course.id)
        
          handtool = self.courses_people.build
          handtool.course = course
          handtool.approver = "System"
          handtool.approved = true
          handtool.date_requested = DateTime.now
          handtool.save
        end
      end
    end
  end
  def remove_tool_permissions
    remove_access = false
    if remove_access
      course = Course.where("lower(name) like ?","%hand tool%").first
      if !course.nil?
        courses_person = self.courses_people.where(:course_id=>course.id).first
        if !courses_person.nil?
          courses_person.destroy
        end
      end
    end
  end
  def tools_late
    self.tool_logs.checked_out.each do |tool_log|
      if tool_log.is_late?
        return true
      else
        return false
      end
    end
    return false
  end
end
