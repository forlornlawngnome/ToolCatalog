class MaintenanceType < ActiveRecord::Base
  belongs_to :category
  has_many :maintenance_actions
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
end
