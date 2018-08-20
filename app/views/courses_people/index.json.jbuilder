json.array!(@courses_people) do |courses_person|
  json.extract! courses_person, :id, :course_id, :person_id, :date_requested, :approver, :approved, :approval_date
  json.url courses_person_url(courses_person, format: :json)
end
