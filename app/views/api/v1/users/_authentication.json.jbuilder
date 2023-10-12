# frozen_string_literal: true

json.extract! user, :id, :name, :status, :birth_date, :uuid, :token, :created_at

json.email user&.obfuscate_email
json.cpf   user&.obfuscate_cpf
json.phone user&.obfuscate_phone