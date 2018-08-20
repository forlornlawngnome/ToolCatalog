class CategoriesTool < ActiveRecord::Base
  belongs_to :tool
  belongs_to :category
  
  validates :category_id, :tool_id, :presence => true
  validates :category_id, :uniqueness => {:scope=>:tool_id}
end
