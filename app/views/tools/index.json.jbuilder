json.array!(@tools) do |tool|
  json.extract! tool, :id, :name, :description, :image, :serial, :barcode, :date_purchased, :capability, :reservable, :max_reservation_time
  json.url tool_url(tool, format: :json)
end
