class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :negotiator, null: false, foreign_key: { to_table: :users }
      t.references :sender,     null: false, foreign_key: { to_table: :users }
      t.belongs_to :book, null: false, foreign_key: true
      t.integer    :status, default: 0
      t.integer    :category, default: 0
      t.date       :negociation_date

      t.timestamps
    end
  end
end
