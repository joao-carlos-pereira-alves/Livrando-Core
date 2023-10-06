class RemoveGenreColumnAndAddNegotiationTypeColumnInBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :genre
    add_column    :books, :negotiation_type, :integer, default: 0
  end
end