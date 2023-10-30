class AddViewedColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :viewed, :boolean, default: false
  end
end
