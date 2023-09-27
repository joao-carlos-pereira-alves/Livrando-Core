# frozen_string_literal: true

json.pagination_params do
  json.page     params[:page].to_i                      || 1
  json.per_page params[:per_page].to_i                  || 4
  json.total    @books.offset(nil).limit(nil).size      || 0
end

json.books do
  json.array! @books, partial: "api/v1/books/book", as: :book
end