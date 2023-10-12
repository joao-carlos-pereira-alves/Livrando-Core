class AddUuidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uuid, :string, default: UUIDTools::UUID.random_create.to_s, null: false
  end
end