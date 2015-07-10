json.array!(@people) do |person|
  json.extract! person, :id, :name, :email, :graduation_year, :barcode, :emergency_contact_name, :emergency_contact_number, :archived, :is_admin, :is_student_admin
  json.url person_url(person, format: :json)
end
