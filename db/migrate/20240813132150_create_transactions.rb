class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :desc
      t.date :date
      t.string :category
      t.integer :amount

      t.timestamps
    end
  end
end
