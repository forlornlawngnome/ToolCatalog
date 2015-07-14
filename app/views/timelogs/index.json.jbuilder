json.array!(@timelogs) do |timelog|
  json.extract! timelog, :id, :person_id, :time_beginning, :time_ending, :duration
  json.url timelog_url(timelog, format: :json)
end
