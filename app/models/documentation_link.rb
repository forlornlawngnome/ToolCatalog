class DocumentationLink < ActiveRecord::Base
  belongs_to :course
  
  validates :name, :link, :presence => true
  
  scope :active, ->{where(:active=>true)}
end
