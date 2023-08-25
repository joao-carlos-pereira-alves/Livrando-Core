class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.belongs_to :reporter, null: false, foreign_key: { to_table: :users }
      t.belongs_to :reported_user, null: false, foreign_key: { to_table: :users }
      t.integer    :reason, default: 0
      t.text       :description

      t.timestamps
    end
  end
end
