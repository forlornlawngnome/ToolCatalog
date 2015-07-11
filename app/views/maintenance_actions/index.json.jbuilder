json.array!(@maintenance_actions) do |maintenance_action|
  json.extract! maintenance_action, :id, :date, :tool_id, :person_id, :maintenance_type_id
  json.url maintenance_action_url(maintenance_action, format: :json)
end
