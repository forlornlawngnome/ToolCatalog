json.array!(@space_reservations) do |space_reservation|
  json.extract! space_reservation, :id, :person_id, :space_id, :reservation_beginning, :reservation_ending, :number_of_people
  json.url space_reservation_url(space_reservation, format: :json)
end
