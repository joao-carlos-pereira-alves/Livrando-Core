# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :paginate, lambda { |page: 1, per_page: 10|
    limit(per_page&.to_i || 10).offset((per_page&.to_i || 1) * ((page&.to_i || 1) - 1))
  }
end
