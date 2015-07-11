class MaintenanceAction < ActiveRecord::Base
  belongs_to :tool
  belongs_to :person
  belongs_to :maintenance_type
  
  validates :date, :tool_id, :person_id, :maintenance_type, :presence => true
end
