# frozen_string_literal: true

class Book < ApplicationRecord
	default_scope { order(publication_year: :asc) }

	belongs_to :added_by,    class_name: "User", foreign_key: :added_by_id
	belongs_to :responsible, class_name: "User", foreign_key: :responsible_id

	has_many :book_categories, dependent: :destroy
	has_many :ratings, as: :evaluable
	has_many :trades, dependent: :destroy
	has_many :favorite_books, dependent: :destroy

	has_one_attached :image

	accepts_nested_attributes_for :book_categories

	enum status:   [ :available, :negotiation_in_progress, :borrowed, :donated, :replacement, :unavailable, :lost ], _prefix: :book_status
	enum negotiation_type: [ :replacement, :loan, :donation ]
	enum language: [
		"Português",
		"Inglês",
		"Espanhol",
		"Francês",
		"Alemão",
		"Chinês",
		"Japonês",
		"Coreano",
		"Árabe",
		"Russo",
		"Italiano",
		"Holandês",
		"Hindi",
		"Bengali",
		"Urdu",
		"Turco",
		"Persa",
		"Vietnamita",
		"Tailandês",
		"Indonésio",
		"Malaio",
		"Suaíli"
	]

	def self.filter(params, books, current_user_id)
		params[:category_ids] = JSON.parse(params[:category_ids])

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

		if params[:favorite].present?
			books = books.joins(:favorite_books).where("favorite_books.user_id = ?", current_user_id)
		end

		if params[:category_ids].present? && !params[:category_ids].empty?
			books = books.joins(:book_categories).where(book_categories: { category_id: params[:category_ids] })
		end

    filter_params.reduce(books) do |relation, (key, filter)|
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

	def average_rating
    total_ratings = ratings.sum(:rating)
    num_ratings = ratings.count

    return 0.5 if num_ratings.zero?  # Retorna 0.5 se não houver ratings.

    average = (total_ratings.to_f / num_ratings).round(1)
    [average, 5.0].min
  end
end