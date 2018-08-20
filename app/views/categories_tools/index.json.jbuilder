json.array!(@categories_tools) do |categories_tool|
  json.extract! categories_tool, :id, :tool_id, :category_id
  json.url categories_tool_url(categories_tool, format: :json)
end
