json.array!(@documentation_links) do |documentation_link|
  json.extract! documentation_link, :id, :name, :link, :course_id, :active
  json.url documentation_link_url(documentation_link, format: :json)
end
