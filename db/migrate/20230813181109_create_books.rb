class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :added_by,    null: false, foreign_key: { to_table: :users }
      t.references :responsible, null: false, foreign_key: { to_table: :users }
      t.string     :author
      t.string     :title
      t.text       :description
      t.integer    :status, default: 0
      t.integer    :genre,  default: 0
      t.string     :isbn
      t.string     :publishing_company
      t.string     :publication_year
      t.integer    :language, default: 0
      t.integer    :amount, default: 0

      t.timestamps
    end
  end
end
