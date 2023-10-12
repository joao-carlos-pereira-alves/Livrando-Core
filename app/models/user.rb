# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Include default devise modules. Others available are:
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :my_responsible_books, class_name: 'Book', foreign_key: :responsible_id, dependent: :destroy
  has_many :created_books,        class_name: 'Book', foreign_key: :added_by_id, dependent: :destroy
  has_many :reports_made,         class_name: 'Report', foreign_key: :reporter_id, dependent: :destroy
  has_many :reports_received,     class_name: 'Report', foreign_key: :reported_user_id, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  has_many :evaluated_objects, class_name: 'Rating', foreign_key: :evaluator_id, dependent: :destroy
  has_many :ratings, as: :evaluable, dependent: :destroy
  has_many :negotiated_trades, class_name: 'Trade', foreign_key: 'negotiator_id', dependent: :destroy
  has_many :sent_trades,       class_name: 'Trade', foreign_key: 'sender_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chat_users, dependent: :destroy

  has_encrypted :email, :cpf, :phone
  blind_index   :email, :cpf, :phone
  
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :name,  :birth_date, :phone, :cpf, presence: true
  validate  :valid_cpf

  enum status: [ :unlocked, :blocked ]

  before_create :create_uuid
  
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

  def create_uuid
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end