class CoursesPerson < ActiveRecord::Base
  before_validation :check_approval
  before_save :set_approval
  belongs_to :course
  belongs_to :person
  
  validates :course_id, :person_id, :presence=>true
  validates :person_id, :uniqueness=>{:scope=>:course_id}
  

  def self.approved
    CoursesPerson.where(:approved=>true)
  end
  def self.not_approved
    if !CoursesPerson.approved.empty?
      CoursesPerson.where("courses_people.id not in (?)",approved.pluck(:id))
    else
      CoursesPerson.all
    end
  end
  def set_approval
    if !self.approved
      self.approved = false
    end
  end
  def check_approval
    if !self.approved
      self.approver = nil
      self.approval_date = nil
    end
  end
end
