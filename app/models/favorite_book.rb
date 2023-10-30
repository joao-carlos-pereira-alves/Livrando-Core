# frozen_string_literal: true

class FavoriteBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
end