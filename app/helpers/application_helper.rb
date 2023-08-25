# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def paginate(model, page: 1, per_page: 10)
    return [] if model.nil?

    model.paginate(page: page, per_page: per_page)
  end
end