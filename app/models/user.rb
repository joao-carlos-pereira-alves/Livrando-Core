class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  def token
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(self, :user, nil)
    token
  end
end