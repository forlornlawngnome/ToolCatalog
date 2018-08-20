json.array!(@spaces) do |space|
  json.extract! space, :id, :name, :max_people, :reservable, :max_reservable_time
  json.url space_url(space, format: :json)
end
