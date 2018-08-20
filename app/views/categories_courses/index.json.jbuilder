json.array!(@categories_courses) do |categories_course|
  json.extract! categories_course, :id, :category_id, :course_id
  json.url categories_course_url(categories_course, format: :json)
end
