class Transaction < ApplicationRecord
  enum transaction_type: { deposit: 0, withdrawal: 1}
  validates :transaction_type, :inclusion => {in: %w(deposit withdrawal), message: "Only diposit and withdrawal are accepted transaction types" }
end
