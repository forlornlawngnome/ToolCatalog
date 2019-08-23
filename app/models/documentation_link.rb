class DocumentationLink < ActiveRecord::Base
  belongs_to :course
  
  #validates :name, :external_link, :presence => true
  
  scope :active, ->{where(:active=>true)}
end
