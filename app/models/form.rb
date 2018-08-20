class Form < ActiveRecord::Base
  has_and_belongs_to_many :people
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
  
  def self.required
    Form.where(:required=>true)
  end
end
