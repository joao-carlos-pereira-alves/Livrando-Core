class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer    :rating
      t.text       :comment
      t.references :evaluator, null: false, foreign_key: { to_table: :users }
      t.references :evaluable, polymorphic: true

      t.timestamps
    end
  end
end