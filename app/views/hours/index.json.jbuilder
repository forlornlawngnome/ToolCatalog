json.array!(@hours) do |hour|
  json.extract! hour, :id, :time_open, :time_close, :person_id, :day_of_week
  json.url hour_url(hour, format: :json)
end
