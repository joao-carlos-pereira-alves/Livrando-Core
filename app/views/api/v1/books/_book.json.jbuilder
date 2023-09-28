json.extract! book, :id, :author, :title, :description, :status, :isbn, :publishing_company, :publication_date, :language, :amount, :created_at, :updated_at

json.categories book.book_categories.map { |bc| bc&.category&.name || '' } if book&.book_categories.present?