require "app/models"
require "faker"

FactoryGirl.define do
  factory :phone_number, class: Naantala::Models::PhoneNumber do
    number { "+639#{Faker::Number.number(9)}" }
    confirmed true
  end
end
