class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :my_responsible_books, class_name: 'Book', foreign_key: :responsible_id, dependent: :destroy
  has_many :created_books,        class_name: 'Book', foreign_key: :added_by_id, dependent: :destroy
  has_many :reports_made, class_name: 'Report', foreign_key: :reporter_id, dependent: :destroy
  has_many :reports_received, class_name: 'Report', foreign_key: :reported_user_id, dependent: :destroy
  has_many :favorite_books, dependent: :destroy

  has_encrypted :email, :cpf, :phone
  blind_index   :email, :cpf, :phone

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :name,  :birth_date, :phone, :cpf, presence: true
  validate  :valid_cpf

  enum status: [ :inactive, :active, :blocked ]
  
  def token
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(self, :user, nil)
    token
  end

  def obfuscate_value(value)
    first_char = value[0]
    asterisks = '*' * [value.length - 1, 0].max
    "#{first_char}#{asterisks}"
  end

  def obfuscate_email
    obfuscate_value(email)
  end

  def obfuscate_phone
    obfuscate_value(phone)
  end

  def obfuscate_cpf
    obfuscate_value(cpf)
  end

  def increment_report_count
    update!(report_count: report_count + 1)
  end

  def block_user
    update!(status: :blocked)
  end

  private

  def valid_cpf
    return if cpf.blank?

    unless CPF.valid?(cpf)
      errors.add(:cpf, :invalid)
    end
  end
end