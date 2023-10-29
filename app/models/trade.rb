# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :negotiator, class_name: "User", foreign_key: :negotiator_id
  belongs_to :sender,     class_name: "User", foreign_key: :sender_id
  belongs_to :book

  after_create :update_book_status, if: :book_pending?
  after_create :initialize_trade

  after_update :end_trade, if: :trade_completed?

  validate :only_one_trade_per_book, on: :create

  enum status:   { pending: 0, accepted: 1, completed: 2 }
  enum category: { replacement: 0, loan: 1, donation: 2 }

  private

  def book_pending?
    book.status.eql?('available')
  end

  def trade_completed?
    self.completed?
  end

  def initialize_trade
    Chat.initialize_trade(sender_id, negotiator_id, book.title)
  end

  def end_trade
    Chat.end_conversation(sender_id, negotiator_id, book.title)
    update_completed_book_status()
  end

  def update_book_status
    book.update(status: :negotiation_in_progress)
  end

  def update_completed_book_status
    amount = book.amount > 1 ? book.amount - 1 : 0
    book.update(status: :completed, amount: amount)
  end

  def only_one_trade_per_book
    if Trade.where(book_id: book_id, sender_id: sender_id, negotiator_id: negotiator_id).exists?
      errors.add(:base, "Já existe uma negociação para este livro")
    end
  end
end