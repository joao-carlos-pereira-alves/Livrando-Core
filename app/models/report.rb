# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :reporter,      class_name: "User", foreign_key: :reporter_id
	belongs_to :reported_user, class_name: "User", foreign_key: :reported_user_id
  
  after_create :block_reported_user, if: :there_three_complaints?
  after_create :increment_report_count, unless: :there_three_complaints?

  validate :cannot_report_self

  enum reason: [ 'Spam', 'Harassment', 'Inappropriate Content', 'Fake Account', 'Other' ]

  private

  def increment_report_count
    reported_user.increment_report_count
  end

  def block_reported_user
    reported_user.block_user
  end

  def there_three_complaints?
    reported_user.report_count.eql?(3)
  end

  def cannot_report_self
    errors.add(:base, I18n.t('api.report.report_yourself_error')) if reporter_id == reported_user_id
  end
end