json.extract! user, :id, :mail, :roomno, :created_at, :updated_at
json.url user_url(user, format: :json)
