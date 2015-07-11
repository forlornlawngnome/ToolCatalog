class CoursesPerson < ActiveRecord::Base
  before_validation :check_approval
  belongs_to :course
  belongs_to :person
  
  validates :course_id, :person_id, :presence=>true
  validates :person_id, :uniqueness=>{:scope=>:course_id}
  
  scope :approved, ->{where(:approved=>true)}
  scope :not_approved, ->{where("courses_people.id not in (?)",approved.pluck(:id)) }


  def check_approval
    if !self.approved
      self.approver = nil
      self.approval_date = nil
    end
  end
end
