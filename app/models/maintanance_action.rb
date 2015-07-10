class MaintananceAction < ActiveRecord::Base
  belongs_to :tool
  belongs_to :person
  belongs_to :maintanance_type
  
  validates :date, :tool_id, :person_id, :maintanance_type, :presence => true
end
