# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    status { :published }
  end
end
