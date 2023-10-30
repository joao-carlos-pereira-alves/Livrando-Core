# frozen_string_literal: true

json.pagination_params do
  json.page     params[:page].to_i                    || 1
  json.per_page params[:per_page].to_i                || 15
  json.total    @messages.offset(nil).limit(nil).size || 0
end

json.messages do
  json.array! @messages, partial: "api/v1/messages/message", as: :message
end