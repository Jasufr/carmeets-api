json.extract! @meeting, :id, :name, :address, :description, :picture
json.comments @meeting.comments do |comment|
  json.extract! comment, :id, :content
  json.user do
    json.id comment.user.id
    json.email comment.user.email
  end
end
