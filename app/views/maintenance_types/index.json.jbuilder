json.array!(@maintenance_types) do |maintenance_type|
  json.extract! maintenance_type, :id, :name, :category_id, :required_hours_between_maintenance
  json.url maintenance_type_url(maintenance_type, format: :json)
end
