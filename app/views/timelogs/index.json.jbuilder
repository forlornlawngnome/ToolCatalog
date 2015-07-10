json.array!(@timelogs) do |timelog|
  json.extract! timelog, :id, :person_id, :time_in, :time_out, :duration
  json.url timelog_url(timelog, format: :json)
end
