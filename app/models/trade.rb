# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :negotiator, class_name: "User", foreign_key: :negotiator_id
  belongs_to :sender,     class_name: "User", foreign_key: :sender_id
  belongs_to :book

  after_create :update_book_status, if: :book_available?

  validate :only_one_trade_per_book

  enum status:   { pending: 0, accepted: 1, completed: 2 }
  enum category: { donation: 0, loan: 1, exchange: 2 }

  private

  def book_available?
    book.available?
  end

  def update_book_status
    book.update(status: :negotiation_in_progress)

    # TODO: add logic for sending notifications if needed
    Thread.new do
    end
  end

  def only_one_trade_per_book
    if Trade.where(book_id: book_id).exists?
      errors.add(:base, "Já existe uma negociação para este livro")
    end
  end
end