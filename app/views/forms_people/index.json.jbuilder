json.array!(@forms_people) do |forms_person|
  json.extract! forms_person, :id, :person_id, :form_id
  json.url forms_person_url(forms_person, format: :json)
end
