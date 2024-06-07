json.array! @meetings do |meeting|
  json.extract! meeting, :id, :name, :address, :description, :picture
end
