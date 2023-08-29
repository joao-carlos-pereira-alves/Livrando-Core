FactoryBot.define do
  factory :message do
    content { "MyString" }
    user { nil }
    chat { nil }
  end
end
