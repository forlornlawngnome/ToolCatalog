class CategoriesCourse < ActiveRecord::Base
  belongs_to :category
  belongs_to :course
  validates :category_id, :course_id, :presence=>true
end
