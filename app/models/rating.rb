# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :evaluable, polymorphic: true
  belongs_to :evaluator, class_name: "User", foreign_key: :evaluator_id
end