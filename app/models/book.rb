# frozen_string_literal: true

class Book < ApplicationRecord
	default_scope { order(publication_year: :asc) }

	belongs_to :added_by,    class_name: "User", foreign_key: :added_by_id
	belongs_to :responsible, class_name: "User", foreign_key: :responsible_id

	has_many :book_categories, dependent: :destroy
	has_many :ratings, as: :evaluable
	has_many :trades, dependent: :destroy

	accepts_nested_attributes_for :book_categories

	enum status:   [ :available, :negotiation_in_progress, :borrowed, :donated, :replacement, :unavailable, :lost ], _prefix: :book_status
	enum negotiation_type: [ :replacement, :loan, :donation ]
	enum language: [
		:portuguese,
		:english,
		:spanish,
		:french,
		:german,
		:chinese,
		:japanese,
		:korean,
		:arabic,
		:russian,
		:italian,
		:dutch,
		:hindi,
		:bengali,
		:urdu,
		:turkish,
		:persian,
		:vietnamese,
		:thai,
		:indonesian,
		:malay,
		:swahili
	]

	def self.filter(params, movies = Movie.all)
    filter_params = [
			[:author, ->(value) { ["author ILIKE ?", "%#{value}%"] }],
      [:title, ->(value) { ["title ILIKE ?", "%#{value}%"] }],
      [:description, ->(value) { ["description ILIKE ?", "%#{value}%"] }],
      [:publication_year, ->(value) { ["publication_year ILIKE ?", "%#{value}%"] }],
      [:publishing_company, ->(value) { ["publishing_company ILIKE ?", "%#{value}%"] }],
      [:isbn, ->(value) { ["isbn ILIKE ?", "%#{value}%"] }],
      [:negotiation_type, ->(value) { ["negotiation_type = ?", "%#{value}%"] }],
      [:language, ->(value) { ["language = ?", "%#{value}%"] }],
			[:amount, ->(value) { ["amount ILIKE ?", "%#{value}%"] }],
			[:status, ->(value) { ["status = ?", "%#{value}%"] }],
			[:responsible, ->(value) { ["responsible_id = ?", value.to_i] }],
			[:added_by, ->(value) { ["added_by_id = ?", value.to_i] }],
			[:created_at, ->(value) { ["created_at = ?", clean_date(value)] }],
      [:updated_at, ->(value) { ["updated_at = ?", clean_date(value)] }]
    ]

    filter_params.reduce(movies) do |relation, (key, filter)|
      if params[key].present?
        relation.where(*filter.call(params[key]))
      else
        relation
      end
    end
  end

  def self.clean_date(date_string)
    if date_string =~ /^\d{2}-\d{2}-\d{4}$/
      date = Date.strptime(date_string, "%d-%m-%Y")
      date_string = date.strftime("%Y-%m-%d")
    elsif date_string =~ %r{^\d{2}/\d{2}/\d{4}$}
      date = Date.strptime(date_string, "%d/%m/%Y")
      date_string = date.strftime("%Y-%m-%d")
    else
      raise ArgumentError, "Invalid date format: #{date_string}. Please use dd-mm-yyyy or dd/mm/yyyy format."
    end
    date_string
  end
end