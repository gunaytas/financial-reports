json.extract! transaction, :id, :desc, :date, :category, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
