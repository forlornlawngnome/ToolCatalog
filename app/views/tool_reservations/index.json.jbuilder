json.array!(@tool_reservations) do |tool_reservation|
  json.extract! tool_reservation, :id, :person_id, :tool_id, :reservation_beginning, :reservation_ending
  json.url tool_reservation_url(tool_reservation, format: :json)
end
