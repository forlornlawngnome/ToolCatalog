json.array!(@hour_exceptions) do |hour_exception|
  json.extract! hour_exception, :id, :time_beginning, :time_ending, :person_id
  json.url hour_exception_url(hour_exception, format: :json)
end
