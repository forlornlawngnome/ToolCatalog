class MaintananceType < ActiveRecord::Base
  belongs_to :category
  has_many :maintanance_actions
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
end
