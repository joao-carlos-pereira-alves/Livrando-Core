class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_encrypted :email, :cpf, :phone
  blind_index   :email, :cpf, :phone

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :name, :birth_date, :phone, :cpf, presence: true
  validate  :valid_cpf
  
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

  private

  def valid_cpf
    return if cpf.blank?

    unless CPF.valid?(cpf)
      errors.add(:cpf, :invalid)
    end
  end
end