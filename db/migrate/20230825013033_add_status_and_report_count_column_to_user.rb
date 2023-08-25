class AddStatusAndReportCountColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :status, :integer,       default: 0
    add_column :users, :report_count, :integer, default: 0
  end
end
