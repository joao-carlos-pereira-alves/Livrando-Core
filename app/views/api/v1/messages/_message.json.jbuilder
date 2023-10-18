json.extract! message, :id, :body, :created_at

json.current_user message.user_id.eql?(current_user.id)