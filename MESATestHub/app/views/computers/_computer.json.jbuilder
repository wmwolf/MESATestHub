json.extract! computer, :id, :platform, :processor, :ram_gb, :created_at, :updated_at, :user_id
json.url computer_url(computer, format: :json)
