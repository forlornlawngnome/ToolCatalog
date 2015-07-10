json.array!(@courses) do |course|
  json.extract! course, :id, :name, :category_id, :additional_info, :recertification
  json.url course_url(course, format: :json)
end
