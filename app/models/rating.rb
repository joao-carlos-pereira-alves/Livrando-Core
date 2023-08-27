class Rating < ApplicationRecord
  belongs_to :evaluable
  belongs_to :evaluator, class_name: "User", foreign_key: :evaluator_id
end