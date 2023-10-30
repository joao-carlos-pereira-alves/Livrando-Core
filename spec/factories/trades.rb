FactoryBot.define do
  factory :trade do
    negotiator { nil }
    sender { nil }
    status { 1 }
    category { 1 }
    negociation_date { "2023-08-27" }
  end
end
