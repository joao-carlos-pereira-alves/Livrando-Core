class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :messages,   dependent: :destroy
<<<<<<< HEAD
=======
  has_many :users, through: :chat_users
>>>>>>> save-dev
end