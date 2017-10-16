require "app/models"
require "faker"

FactoryGirl.define do
  factory :phone_number, class: Naantala::Models::PhoneNumber do
    number { "+63#{Faker::Number.number(10)}" }
    confirmed true
  end
end
