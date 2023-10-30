# frozen_string_literal: true

json.extract! user, :id, :name, :status, :birth_date, :uuid, :created_at

json.email user&.obfuscate_email
json.cpf   user&.obfuscate_cpf
json.phone user&.obfuscate_phone

if user.avatar.attached?
  json.avatar do
    json.name user.avatar.filename.to_s if user.avatar.filename
    json.url url_for(user.avatar) if user.avatar
    json.signed_id user.avatar.signed_id if user.avatar.signed_id
  end
end