json.array!(@maintanance_actions) do |maintanance_action|
  json.extract! maintanance_action, :id, :date, :tool_id, :person_id, :maintanance_type_id
  json.url maintanance_action_url(maintanance_action, format: :json)
end
