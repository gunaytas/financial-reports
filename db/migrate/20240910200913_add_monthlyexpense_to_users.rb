class AddMonthlyexpenseToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :monthlyexpense, :integer
  end
end
