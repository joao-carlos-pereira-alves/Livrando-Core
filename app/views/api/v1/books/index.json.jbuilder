# frozen_string_literal: true

json.pagination_params do
  json.page     params[:page].to_i                      || 1
  json.per_page params[:per_page].to_i                  || 4
  if params[:dashboard_view] == true
    json.total [12, @books.offset(nil).limit(nil).size].min || 1
  else
    json.total @books.offset(nil).limit(nil).size || 1
  end
end

json.books do
  json.array! @books, partial: "api/v1/books/book", as: :book
end