class FormsPerson < ActiveRecord::Base
  belongs_to :person
  belongs_to :form
  
  validates :person_id, :form_id, :presence => true
  validates :form_id, :uniqueness => { :scope => :person_id }

  before_save :add_tool_permissions

  def add_tool_permissions
    give_access = true
    Form.all.each do |form|
      if form.required
        if !self.person.forms.pluck(:form_id).include?(form.id)
          give_access = false
        end
      end
    end
    if give_access
      course = Course.where("lower(name) like ?","%hand tool%").first
      if !course.nil?
        handtool = self.person.courses_people.build
        handtool.course = course
        handtool.approver = "System"
        handtool.approved = true
        handtool.date_requested = DateTime.now
        handtool.save
      end
    end
  end
end
