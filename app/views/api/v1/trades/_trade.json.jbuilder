json.extract! trade, :id, :negotiator_id, :sender_id, :status, :category, :negociation_date, :created_at, :updated_at

book = trade.book

if book.present?
  json.book do
    json.partial! "api/v1/books/book.json.jbuilder", book: book
  end
end