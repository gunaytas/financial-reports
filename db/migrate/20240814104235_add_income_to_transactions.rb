class AddIncomeToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :income, :boolean
  end
end
