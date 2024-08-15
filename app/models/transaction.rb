class Transaction < ApplicationRecord
    belongs_to :user

    validates :amount, presence: true
    validates :desc, presence: true
    validates :date, presence: true
    validates :income, inclusion: { in: [true, false] }
end
