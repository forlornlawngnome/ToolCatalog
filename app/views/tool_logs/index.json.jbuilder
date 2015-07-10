json.array!(@tool_logs) do |tool_log|
  json.extract! tool_log, :id, :tool_id, :person_id, :time_in, :time_out, :duration, :tool_reservation_id
  json.url tool_log_url(tool_log, format: :json)
end
