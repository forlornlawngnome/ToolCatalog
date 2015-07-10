json.array!(@maintanance_types) do |maintanance_type|
  json.extract! maintanance_type, :id, :name, :category_id, :required_hours_between_maintanance
  json.url maintanance_type_url(maintanance_type, format: :json)
end
