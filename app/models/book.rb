class Book < ApplicationRecord
	belongs_to :added_by,    class_name: "User", foreign_key: :added_by_id
	belongs_to :responsible, class_name: "User", foreign_key: :responsible_id

	enum status:   [ :available, :unavailable ]
	enum genre:    [ :male, :female, :others ]
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
end