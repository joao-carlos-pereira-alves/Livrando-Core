class AddIndexToUuidOnUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :uuid, unique: true
  end
end