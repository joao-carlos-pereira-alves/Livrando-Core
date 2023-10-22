json.extract! book, :id, :author, :title, :description, :status, :isbn, :negotiation_type, :publishing_company, :publication_year, :language, :amount, :created_at, :updated_at

json.categories book.book_categories.map { |bc| bc&.category&.name || '' } if book&.book_categories.present?

json.favorited book&.favorite_books&.find_by(user_id: current_user.id).present?

if book.image.attached?
  json.image do
    json.name book.image.filename.to_s if book.image.filename
    json.url url_for(book.image) if book.image
    json.signed_id book.image.signed_id if book.image.signed_id
  end
end