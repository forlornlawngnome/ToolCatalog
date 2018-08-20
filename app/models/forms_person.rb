class FormsPerson < ActiveRecord::Base
  belongs_to :person
  belongs_to :form
  
  validates :person_id, :form_id, :presence => true
  validates :form_id, :uniqueness => { :scope => :person_id }
end
