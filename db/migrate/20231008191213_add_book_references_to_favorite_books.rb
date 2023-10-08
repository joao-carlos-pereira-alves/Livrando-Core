class AddBookReferencesToFavoriteBooks < ActiveRecord::Migration[6.1]
  def change
    add_reference :favorite_books, :book, foreign_key: true
  end
end
